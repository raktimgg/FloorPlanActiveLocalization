# ifndef ZEDCLOUD_H_
#define  ZEDCLOUD_H_

//ROS
#include <ros/ros.h>
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <sensor_msgs/PointCloud2.h>
#include <sem_cloud/RGBDImage.h>
#include <sem_cloud/MapGraph.h>

// OpenCV
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>

// Pcl
#include <pcl/common/eigen.h>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/common/eigen.h>
#include <pcl/common/transforms.h>

class filter
{
    private:
        typedef message_filters::sync_policies::ApproximateTime<sem_cloud::RGBDImage, sensor_msgs::Image,sensor_msgs::Image,sem_cloud::MapGraph> MySyncPolicy;
        ros::NodeHandle nh_;
        ros::Publisher rtabmapCloud;
        ros::Publisher zedCloud;
        message_filters::Subscriber<sensor_msgs::Image>   zedRGB_;
        message_filters::Subscriber<sensor_msgs::Image>   zedDepth_;
        message_filters::Subscriber<sem_cloud::MapGraph>  rtabmapInfo_;
        message_filters::Subscriber<sem_cloud::RGBDImage> rtabmapImage_;
        message_filters::Synchronizer<filter::MySyncPolicy> sync_;
        pcl::PointCloud<pcl::PointXYZ>::Ptr createCloud(cv::Mat grayImage, cv::Mat depthImage);

    public:
    filter();
    ~filter();

    void filter_cb(const sem_cloud::RGBDImageConstPtr& rgbdImage, const sensor_msgs::ImageConstPtr& rgbImage, const sensor_msgs::ImageConstPtr& depthImage , const sem_cloud::MapGraphConstPtr rtabInfo);  
    
    Eigen::Matrix4f poseToTransform(geometry_msgs::Pose nodePose)
    {
        Eigen::Matrix3f rotation = Eigen::Quaternionf(nodePose.orientation.w, nodePose.orientation.x, nodePose.orientation.y, nodePose.orientation.z).toRotationMatrix();
        Eigen::Matrix4f transformation;
        transformation <<    rotation(0,0) , rotation(0,1) , rotation(0,2), nodePose.position.x,
                             rotation(1,0) , rotation(1,1) , rotation(1,2), nodePose.position.y,
                             rotation(2,0) , rotation(2,1) , rotation(2,2), nodePose.position.z,
                                0      ,      0        ,       0      ,           1           ;
        return transformation;
    };

        pcl::PointCloud<pcl::PointXYZ>::Ptr transformCloud(const pcl::PointCloud<pcl::PointXYZ>::Ptr localCloud, Eigen::Matrix4f transform )
    {
        pcl::PointCloud<pcl::PointXYZ>::Ptr output(new pcl::PointCloud<pcl::PointXYZ>);
        output ->resize(localCloud->size());
        pcl::transformPointCloud(*localCloud, *output, transform);
        return output;
    };












    pcl::PointXYZ projectDepthTo3D(
        const cv::Mat depthImage,
        float w, float h,
        float cx, float cy,
        float fx, float fy
)
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
};
#endif
