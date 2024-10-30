#ifndef CURRENTCLOUD_H_
#define CURRENTCLOUD_H_

#include <ros/ros.h>
#include <ros/console.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/PointCloud2.h>
#include <cv_bridge/cv_bridge.h>
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <pcl/common/eigen.h>
#include <pcl/common/io.h>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <pcl/common/transforms.h>
#include <pcl/filters/filter.h>
#include <pcl_conversions/pcl_conversions.h>

class currentCloud
{
private:
    typedef message_filters::sync_policies::ApproximateTime<sensor_msgs::Image, sensor_msgs::Image, sensor_msgs::CameraInfo> cloudSyncPolicy_;
    message_filters::Subscriber<sensor_msgs::Image> rgbImage_;
    message_filters::Subscriber<sensor_msgs::Image> depthMap_;
    message_filters::Subscriber<sensor_msgs::CameraInfo> cameraIntrensics_;
    message_filters::Synchronizer<currentCloud::cloudSyncPolicy_> sync_;
    ros::Publisher localCloud_;
    void cloudCallBack_(const sensor_msgs::Image::ConstPtr& rgb, const sensor_msgs::Image::ConstPtr& depthMap, const sensor_msgs::CameraInfo::ConstPtr& cameraIntrensics);
    pcl::PointXYZ projectDepthTo3D_(const cv::Mat depthMap, float w, float h, float cx, float cy, float fx, float fy);
public:
    currentCloud(ros::NodeHandle *nh);
    ~currentCloud();
};

#endif