#include "semanticCloud.h"

// Constructor
cloud::cloud(ros::NodeHandle *nh)
{
    semanticCloud = nh->advertise<sensor_msgs::PointCloud2>("/sync/cloud", 1);
    semanticLocalCloud = nh->advertise<sensor_msgs::PointCloud2>("/sync/local_cloud", 1);
    localCloud = nh->advertise<sensor_msgs::PointCloud2>("/sync/localCloud", 1);
    imgposedata   = nh->subscribe("/sync/RGBDS", 100, &cloud::cloudCallback, this);
    nodes     = nh->advertise<sem_cloud::nodes>("sync/nodes",100);
    ztest     = nh->advertise<std_msgs::Float32>("sync/z",10);
}

// Function for creation of transformation matrix
Eigen::Matrix4f cloud::poseToTransform(geometry_msgs::Pose nodePose)
{
    Eigen::Matrix3f rotation = Eigen::Quaternionf(nodePose.orientation.w, nodePose.orientation.x, nodePose.orientation.y, nodePose.orientation.z).toRotationMatrix();
    Eigen::Matrix4f transformation;
    transformation <<    rotation(0,0) , rotation(0,1) , rotation(0,2), nodePose.position.x,
                            rotation(1,0) , rotation(1,1) , rotation(1,2), nodePose.position.y,
                            rotation(2,0) , rotation(2,1) , rotation(2,2), nodePose.position.z,
                            0      ,      0        ,       0      ,           1           ;
    return transformation;
};

// Transforming Position of cloud
pcl::PointCloud<pcl::PointXYZRGBL>::Ptr cloud::transformCloud(const pcl::PointCloud<pcl::PointXYZRGBL>::Ptr localCloud, Eigen::Matrix4f transform )
{
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output(new pcl::PointCloud<pcl::PointXYZRGBL>);
    output ->resize(localCloud->size());
    pcl::transformPointCloud(*localCloud, *output, transform);

    return output;
};

// PointCloud Filtering function
pcl::PointCloud<pcl::PointXYZRGBL>::Ptr cloud::filterCloud(const pcl::PointCloud<pcl::PointXYZRGBL>::Ptr inputCloud,int n)
{
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output_filtered(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output_filtered2(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr cloud_filtered (new pcl::PointCloud<pcl::PointXYZRGBL>);       
    
    
    // Voxel grid filtering
    pcl::VoxelGrid<pcl::PointXYZRGBL> filter;                           // Creating voxel grid filter
    filter.setDownsampleAllData(true);
    filter.setLeafSize(0.1f, 0.1f, 0.1f);                          // Defining the grid size for down-sampling
    filter.setInputCloud(inputCloud);                                // setting input cloud
    filter.filter(*output_filtered);                                 // Filtering and saving in new point-cloud
    
    return output_filtered;
};

// Projecting to pixel point to 3D location
pcl::PointXYZ cloud::projectDepthTo3D( const cv::Mat depthImage, float w, float h, float cx, float cy,float fx, float fy)
{
    pcl::PointXYZ pt;
    float depth = depthImage.at<float>(h,w);
    if(depth > 0.0f)
    {
        // Fill in XYZ
        pt.x = (w - cx) * depth / fx;
        pt.y = (h - cy) * depth / fy;
        pt.z = depth;
    }
    else
    {
        pt.x = pt.y = pt.z = std::numeric_limits<float>::quiet_NaN();
    }
    return pt;
}

/**
 * @brief Callback function for processing incoming image and pose data.
 * 
 * This function is triggered whenever a new message is received on the subscribed topic.
 * It processes the RGB, depth, and semantic images to create and filter point clouds.
 * It also calculates the height of the camera using semantic information and publishes
 * the processed point clouds and camera height.
 * 
 * @param input The input message containing image and pose data.
 */
void cloud::cloudCallback(const sem_cloud::imageposeConstPtr& input)
{
    static int seq = 0;
    static int previous_len;
    int length = input->length;
    
    // To Calculate height of camera using semantics
    int zCount = 0;
    float zValue = 0;
    static float zAverage = 1.3;

    // Reading the image, semantic, pose data from the message
    cv_bridge::CvImageConstPtr rgb = cv_bridge::toCvCopy(input->rgb, sensor_msgs::image_encodings::BGR8);
    cv_bridge::CvImageConstPtr depth = cv_bridge::toCvCopy(input->depth);
    cv_bridge::CvImageConstPtr semantics = cv_bridge::toCvCopy(input->semantic);
    cv::Mat current_image = rgb->image;
    cv::Mat imageDepth = depth->image;  
    cv::Mat sem_image = semantics->image;
    cv::Mat imageGray;
    cv::cvtColor(current_image, imageGray, CV_BGR2GRAY);    

    // Creating a pointCloud
    static pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output_con(new pcl::PointCloud<pcl::PointXYZRGBL>);
    static pcl::PointCloud<pcl::PointXYZRGBL>::Ptr previous_con(new pcl::PointCloud<pcl::PointXYZRGBL>);

    // Change with every message     
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr outputFiltered(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr cloudLocal(new pcl::PointCloud<pcl::PointXYZRGBL>);

    int decimation = 4;
    // Global Cloud
    cloud->height = imageGray.rows / decimation;
    cloud->width = imageGray.cols / decimation;
    cloud->is_dense = false;
    cloud->resize(cloud->height * cloud->width);	
    // Local cloud 
    cloudLocal->height = imageGray.rows / decimation;
    cloudLocal->width = imageGray.cols / decimation;
    cloudLocal->is_dense = false;
    cloudLocal->resize(cloud->height * cloud->width);
    
    int p = 0;
    for (int h = 0; h < imageGray.rows && h / decimation < (int)cloud->height; h += decimation)
    {
        for (int w = 0; w < imageGray.cols && w / decimation < (int)cloud->width; w += decimation)
        {
            pcl::PointXYZRGBL &pt = cloud->at((h / decimation) * cloud->width + (w / decimation));               // Global Cloud
            pcl::PointXYZRGBL &pt2 = cloudLocal->at((h / decimation) * cloudLocal->width + (w / decimation));   // Local Cloud

            int x = (w);
            int y = (h);
            // Local Cloud
            pt2.r = pt.r = current_image.at<cv::Vec3b>(y, x)[2];
            pt2.g = pt.g = current_image.at<cv::Vec3b>(y, x)[1];
            pt2.b = pt.b = current_image.at<cv::Vec3b>(y, x)[0];
            pt2.label = pt.label = sem_image.at<uchar>(h, w);
            pcl::PointXYZ ptXYZ = projectDepthTo3D(imageDepth, w, h, 335.05673, 193.89366, 261.76797, 261.76797);  // ZED = 336.1044921875, 190.03286743164062, 335.8936767578125 , 336.1044921875  //Zed2 335.05673, 193.89366, 261.76797, 261.76797  // Zedm = 336.1044921875, 190.03286743164062, 335.8936767578125 , 336.1044921875            
            // Global Point Cloud
            if (pcl::isFinite(ptXYZ) && ptXYZ.z >= 0.0 && ptXYZ.z < 3.5 && (pt.label == 14 || pt.label == 0)) 
            {
                p++;
                pt.x = ptXYZ.z;
                pt.y = -ptXYZ.x;
                pt.z = -ptXYZ.y;		
            }
            else
            {
                pt.x = pt.y = pt.z = std::numeric_limits<float>::quiet_NaN();
            }
            // Local Point Cloud
            if (pcl::isFinite(ptXYZ)) 
            {
                p++;
                pt2.x = ptXYZ.z;
                pt2.y = -ptXYZ.x;
                pt2.z = -ptXYZ.y;		
            }
            else
            {
                pt2.x = pt2.y = pt2.z = std::numeric_limits<float>::quiet_NaN();
            }	 
            // Calculating semantic Camera Height
            if (pt.label == 3) 
            {
                if (abs(ptXYZ.y - zAverage) < 0.3 && pcl::isFinite(ptXYZ))
                {
                    zValue += ptXYZ.y;
                    zCount += 1;
                }
            }
        }
    }
    std::vector<int> index;
    pcl::removeNaNFromPointCloud(*cloud, *cloud, index);	

    // Local cloud 
    sensor_msgs::PointCloud2 cloudMsgL;
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr outputFilteredLocal(new pcl::PointCloud<pcl::PointXYZRGBL>);
    outputFilteredLocal = filterCloud(cloudLocal, 2);
    pcl::toROSMsg(*outputFilteredLocal, cloudMsgL);
    cloudMsgL.header.frame_id = "agent_sensor";
    cloudMsgL.header.stamp = input->header.stamp;
    semanticLocalCloud.publish(cloudMsgL);
    cloudMsgL.header.stamp = ros::Time::now();
    localCloud.publish(cloudMsgL);

    // Publishing Semantic Z value
    if (abs((zValue / zCount) - zAverage) < 0.4)
    {
        zAverage = 0.6 * zAverage + 0.4 * zValue / zCount;
    }
    std_msgs::Float32 msg;
    msg.data = zAverage;
    ztest.publish(msg);

    if (seq == 0)
    {
        start_len = length;
        previousCloud = cloud;
        previousId = input->poseId[start_len - 1];
        ROS_INFO("Id is: %i and length: %i", previousId, length);
        previous_len = length;
        previous_con->clear();
    }

    if (length - previous_len >= 1)
    {
        previous_len = length;
        // Saving the cloud data
        cloud::clouds_.insert(std::make_pair(previousId, previousCloud));
        poseIds.push_back(previousId);
        nodes_array.posesId.push_back(previousId);
        nodes.publish(nodes_array);

        // Working on output cloud
        previous_con->clear();
        previousCloud = cloud;
        previousId = input->poseId[length - 1];
        *previous_con = *output_con;    // Only changes when a key frame is appended
        output = transformCloud(previousCloud, poseToTransform(input->pose[length - 1]));
        *output_con = *previous_con + *output;
    }
    else
    {
        // Not a new node
        previousCloud->clear();
        output_con->clear();
        previousCloud = cloud;
        previousId = input->poseId[length - 1];
        output = transformCloud(previousCloud, poseToTransform(input->pose[length - 1]));        
        *output_con = *previous_con + *output;
    }

    // Loop Closure and graph Optimization
    if (true) 
    {
        ROS_INFO("Updating the cloud");

        std::vector<int> current_poseIDs = poseIds;
        ROS_INFO("Size of pose Id is %ld", current_poseIDs.size());
        output_con->clear();
        
        for (int i = 0; i < current_poseIDs.size(); i++)
        {
            int node = poseIds[i];
            ROS_INFO("Searching for node %d", node);
            pcl::PointCloud<pcl::PointXYZRGBL>::Ptr curent_update_cloud = cloud::clouds_.find(node)->second;
            ROS_INFO("transforming cloud with pose Id is %ld", curent_update_cloud->size());
            auto output_ = transformCloud(curent_update_cloud, poseToTransform(input->pose[start_len - 1 + i]));
            *output_con += *output_;
        }
        previous_con->clear();
        *previous_con = *output_con;
    }    
    *output_con = *previous_con + *output;
    // Publishing a Global cloud    
    sensor_msgs::PointCloud2 cloudMsg;
    output_con = filterCloud(output_con, 1);
    pcl::toROSMsg(*output_con, cloudMsg);
    cloudMsg.header = input->header;
    semanticCloud.publish(cloudMsg);
    seq += 1;
}

int main(int argc, char **argv)
{
    ros::init(argc,argv,"cloud");
    ros::NodeHandle nh;
    cloud sem_cloud = cloud(&nh);
    ros::spin();
    return 0;
}



