#include "filterNode.h"
#include "sem_cloud/imagepose.h"

// Constructor for the filter class
filter::filter() : sync_(filter::MySyncPolicy(100), filter::rgbdImage_, filter::semanticImage_, filter::mapGraph_, filter::mapInfo_, filter::rtabmapCloud_)
{
    // Advertise topics
    filter::syncRGBDImage_ = filter::nh_.advertise<sem_cloud::RGBDImage>("Sync/RGBDImage", 1);
    filter::syncSemantic_  = filter::nh_.advertise<sensor_msgs::Image>("Sync/Semantic", 1);
    filter::syncimagepose_ = filter::nh_.advertise<sem_cloud::imagepose>("sync/RGBDS", 1);

    // Subscribe to topics
    filter::rgbdImage_.subscribe(filter::nh_, "/rtabmap/rgbd_image", 40);
    filter::semanticImage_.subscribe(filter::nh_, "/rtabmap/segmentated", 1);
    filter::mapGraph_.subscribe(filter::nh_, "/rtabmap/mapGraph", 50);
    filter::mapInfo_.subscribe(filter::nh_, "rtabmap/info", 20);
    filter::rtabmapCloud_.subscribe(filter::nh_, "/rtabmap/cloud_map", 20);

    // Register callback for synchronized messages
    filter::sync_.registerCallback(std::bind(&filter::filter_cb, this, std::placeholders::_1, std::placeholders::_2, std::placeholders::_3, std::placeholders::_4, std::placeholders::_5));

    filter::firstFrame_ = true;
}

// Destructor for the filter class
filter::~filter()
{
}

// Callback function for synchronized messages
void filter::filter_cb(const sem_cloud::RGBDImage::ConstPtr& image, const sensor_msgs::Image::ConstPtr& semImage, const sem_cloud::MapGraph::ConstPtr& graph, const sem_cloud::Info::ConstPtr& info, const sensor_msgs::PointCloud2::ConstPtr& rtabmap)
{
    if (filter::firstFrame_)
    {
        std::cout << "frame1" << std::endl;
        filter::currentImage_ = image;
        filter::firstFrame_ = false;
    }
    else
    {
        std::cout << "Filtered" << std::endl;
        filter::previousImage_ = filter::currentImage_;
        filter::currentImage_ = image;

        // Publish synchronized messages
        filter::syncRGBDImage_.publish(filter::currentImage_);
        filter::syncSemantic_.publish(semImage);

        int length = graph->posesId.size();

        // Prepare and publish the combined message
        sem_cloud::imagepose pub_msg;
        pub_msg.header = semImage->header;
        pub_msg.rgb = filter::currentImage_->rgb;
        pub_msg.depth = filter::currentImage_->depth;
        pub_msg.semantic.header = semImage->header;
        pub_msg.semantic.height = semImage->height;
        pub_msg.semantic.width = semImage->width;
        pub_msg.semantic.encoding = semImage->encoding;
        pub_msg.semantic.step = semImage->step;
        pub_msg.semantic.data = semImage->data;
        pub_msg.length = length;
        pub_msg.pose = graph->poses;
        pub_msg.poseId = graph->posesId;
        pub_msg.loopclosureId = info->loopClosureId;
        pub_msg.proximityDetectionId = info->proximityDetectionId;
        pub_msg.rtabmapPcl.header = rtabmap->header;
        pub_msg.rtabmapPcl.height = rtabmap->height;
        pub_msg.rtabmapPcl.width = rtabmap->width;
        pub_msg.rtabmapPcl.fields = rtabmap->fields;
        pub_msg.rtabmapPcl.is_bigendian = rtabmap->is_bigendian;
        pub_msg.rtabmapPcl.point_step = rtabmap->point_step;
        pub_msg.rtabmapPcl.row_step = rtabmap->row_step;
        pub_msg.rtabmapPcl.data = rtabmap->data;
        pub_msg.rtabmapPcl.is_dense = rtabmap->is_dense;

        filter::syncimagepose_.publish(pub_msg);

        ROS_INFO("Id is: %i", pub_msg.poseId[pub_msg.poseId.size() - 1]);
        ROS_INFO("Proximity ID: %i", pub_msg.proximityDetectionId);
        ROS_INFO("Published synced message");
    }
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "filter");
    filter start;
    ros::spin();

    return 0;
}
