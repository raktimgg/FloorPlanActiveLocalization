#ifndef SYNCHRONIZER_H_
#define SYNCHRONIZER_H_

#include <ros/ros.h>
#include <ros/console.h>
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
		typedef message_filters::sync_policies::ApproximateTime<sem_cloud::RGBDImage, sensor_msgs::Image, sem_cloud::MapGraph, sem_cloud::Info> MySyncPolicy;
		ros::Publisher syncRGBDImage_;
    		ros::Publisher syncSemantic_;
    		ros::Publisher syncimagepose_;    
    		message_filters::Subscriber<sensor_msgs::Image>  semanticImage_;
    		message_filters::Subscriber<sem_cloud::RGBDImage> rgbdImage_;
    		message_filters::Subscriber<sem_cloud::MapGraph>  mapGraph_;           //
    		message_filters::Subscriber<sem_cloud::Info>      mapInfo_;
    		message_filters::Synchronizer<filter::MySyncPolicy> sync_;
    		void filter_cb(const sem_cloud::RGBDImage::ConstPtr& image, const sensor_msgs::Image::ConstPtr& semImage, const sem_cloud::MapGraph::ConstPtr& graph, const sem_cloud::Info::ConstPtr& info);//
    	public:
    		filter(ros::NodeHandle *nh);
    		~filter();
};


#endif
