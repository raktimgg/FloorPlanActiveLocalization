#include "currentCloud.h"


currentCloud::currentCloud(ros::NodeHandle *nh) : sync_(currentCloud::cloudSyncPolicy_(100), this->rgbImage_, this->depthMap_, this->cameraIntrensics_)
{
    this->localCloud_ = nh->advertise<sensor_msgs::PointCloud2>("agent/cloud", 100);
    this->rgbImage_.subscribe(*nh, "/zed2/zed_node/rgb/image_rect_color", 100);
    this->depthMap_.subscribe(*nh, "/zed2/zed_node/depth/depth_registered", 100);
    this->cameraIntrensics_.subscribe(*nh, "/zed2/zed_node/depth/camera_info", 100);
    this->sync_.registerCallback(std::bind(&currentCloud::cloudCallBack_, this, std::placeholders::_1, std::placeholders::_2, std::placeholders::_3));
}

currentCloud::~currentCloud()
{
}
// Method to project a point from depth map to 3D space using the camera intrinsics
pcl::PointXYZ currentCloud::projectDepthTo3D_(const cv::Mat depthMap, float w, float h, float cx, float cy, float fx, float fy)
{
    pcl::PointXYZ pt;
    float depth = depthMap.at<float>(h, w);
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
// Callback function to process synchronized RGB, depth, and camera info messages
void currentCloud::cloudCallBack_(const sensor_msgs::Image::ConstPtr& rgb, const sensor_msgs::Image::ConstPtr& depthMap, const sensor_msgs::CameraInfo::ConstPtr& cameraIntrensics)
{
    cv_bridge::CvImagePtr rgb_ptr, depthMap_ptr;
    try
    {
        rgb_ptr = cv_bridge::toCvCopy(rgb, sensor_msgs::image_encodings::BGR8);
        depthMap_ptr = cv_bridge::toCvCopy(depthMap);
    }
    catch(cv_bridge::Exception& e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }
    
    //Image and depth Map
    cv::Mat rgbImage = rgb_ptr->image;
    cv::Mat depth = depthMap_ptr->image;

    //declaring point cloud
    pcl::PointCloud<pcl::PointXYZRGB>::Ptr localCloud(new pcl::PointCloud<pcl::PointXYZRGB>);

    //In camera frame (local cloud)
    int decimation = 1;
    localCloud->height = rgbImage.rows/decimation;
    localCloud->width  = rgbImage.cols/decimation;
    localCloud->is_dense = false;
    localCloud->resize(localCloud->height * localCloud->width);		
    for(int h = 0; h < rgbImage.rows && h/decimation < (int)localCloud->height ; h+=decimation)
    {
        for(int w = 0; w < rgbImage.cols && w/decimation < (int)localCloud->width ; w+=decimation)
        {
            pcl::PointXYZRGB & pt = localCloud->at((h/decimation)*localCloud->width + (w/decimation));

            int x = (w);
            int y = (h);
            pt.r = rgbImage.at<cv::Vec3b>(y, x)[2];
            pt.g = rgbImage.at<cv::Vec3b>(y, x)[1];
            pt.b = rgbImage.at<cv::Vec3b>(y, x)[0];
            pcl::PointXYZ ptXYZ = this->projectDepthTo3D_(depth, w, h, cameraIntrensics->K[2], cameraIntrensics->K[5], cameraIntrensics->K[0], cameraIntrensics->K[4]);
            if(pcl::isFinite(ptXYZ) && ptXYZ.z >= 0.0f && ptXYZ.z <= 5.0f) 
            {
                pt.x =  ptXYZ.z;
                pt.y = -ptXYZ.x;
                pt.z = -ptXYZ.y;
            }
            else pt.x = pt.y = pt.z = std::numeric_limits<float>::quiet_NaN();
        }
    }

    //Removing NaNs from local cloud
    std::vector<int> index;
    pcl::removeNaNFromPointCloud(*localCloud, *localCloud, index);

    //To ROS msg
    sensor_msgs::PointCloud2 cloud;
    pcl::toROSMsg(*localCloud, cloud);
    cloud.header.stamp = ros::Time::now();
    cloud.header.frame_id = "base_link3";
    this->localCloud_.publish(cloud);
}
// Main function to initialize the ROS node 
int main(int argc, char** argv)
{
	ros::init(argc, argv, "agent");
	ros::NodeHandle nh;
	currentCloud* currentCloud_ = new currentCloud(&nh);
	ros::spin();
	return 0;
}
