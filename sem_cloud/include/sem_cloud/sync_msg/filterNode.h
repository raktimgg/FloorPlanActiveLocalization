#ifndef FILTERNODE_H_
#define FILTERNODE_H_

#include <ros/ros.h>
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <sensor_msgs/PointCloud2.h>
#include "sem_cloud/RGBDImage.h"
#include "sem_cloud/imagepose.h"
#include "sem_cloud/Semantic.h"
#include "sem_cloud/MapGraph.h"
#include "sem_cloud/Info.h"

class filter
{
private:
    typedef message_filters::sync_policies::ApproximateTime<sem_cloud::RGBDImage, sensor_msgs::Image, sem_cloud::MapGraph, sem_cloud::Info, sensor_msgs::PointCloud2> MySyncPolicy; //
    ros::NodeHandle nh_;
    ros::Publisher syncRGBDImage_;
    ros::Publisher syncSemantic_;
    ros::Publisher syncimagepose_;    
    message_filters::Subscriber<sensor_msgs::Image>  semanticImage_;
    message_filters::Subscriber<sem_cloud::RGBDImage> rgbdImage_;
    message_filters::Subscriber<sem_cloud::MapGraph>  mapGraph_;           //
    message_filters::Subscriber<sem_cloud::Info>      mapInfo_;
    message_filters::Subscriber<sensor_msgs::PointCloud2> rtabmapCloud_;
    message_filters::Synchronizer<filter::MySyncPolicy> sync_;
    sem_cloud::RGBDImageConstPtr previousImage_;
    sem_cloud::RGBDImageConstPtr currentImage_;
    bool firstFrame_;

public:
    filter();
    ~filter();
    void filter_cb(const sem_cloud::RGBDImage::ConstPtr& image, const sensor_msgs::Image::ConstPtr& semImage, const sem_cloud::MapGraph::ConstPtr& graph, const sem_cloud::Info::ConstPtr& info, const sensor_msgs::PointCloud2::ConstPtr& rtabmap);//
};


#endif
