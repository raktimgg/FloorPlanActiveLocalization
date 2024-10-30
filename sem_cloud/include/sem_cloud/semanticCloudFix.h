#ifndef SEMANTICCLOUDFIX_H_
#define SEMANTICCLOUDFIX_H_

// ROS Include files
#include <iostream>
#include <ros/ros.h>
#include <ros/console.h>

// Message includes
#include <std_msgs/Float32.h>
#include <std_msgs/Int32.h>
#include <std_msgs/String.h>
#include <geometry_msgs/Pose.h>
#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/PointCloud2.h>
#include <nav_msgs/Odometry.h>

// Custom Message includes
#include "sem_cloud/MapGraph.h"
#include "sem_cloud/nodes.h"
#include "sem_cloud/RGBDImage.h"
#include "sem_cloud/Info.h"
#include "sem_cloud/Semantic.h"
#include "sem_cloud/rgbdss.h"
#include "sem_cloud/nodes.h"
#include "sem_cloud/imagepose.h"

// Point cloud includes
#include<pcl/pcl_config.h>
#include <pcl/common/eigen.h>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <pcl/common/transforms.h>
#include <pcl_conversions/pcl_conversions.h>

// Point Cloud filter includes
#include <pcl/filters/voxel_grid.h>
#include <pcl/filters/radius_outlier_removal.h>
#include <pcl/filters/statistical_outlier_removal.h>

// Opencv includes
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>

class cloud
{
	private:
		ros::Subscriber imgposedata;
    		ros::Publisher  semanticCloud;
		ros::Publisher  semanticLocalCloud;
		ros::Publisher  localCloud;
		ros::Publisher  ztest;
    		ros::Publisher nodes;
    		std::map<int, pcl::PointCloud<pcl::PointXYZRGBL>::Ptr> clouds_;
    		// Variables used by constructor
    		int start_len;
    		int previousId;
    		std::vector<int> poseIds;
    		std::vector<int> messsage;
    		sem_cloud::nodes nodes_array;
    		pcl::PointCloud<pcl::PointXYZRGBL>::Ptr previousCloud;
    		// Functions
    		void cloudCallback(const sem_cloud::imageposeConstPtr& input);
    		Eigen::Matrix4f poseToTransform(geometry_msgs::Pose nodePose);
    		pcl::PointCloud<pcl::PointXYZRGBL>::Ptr transformCloud(const pcl::PointCloud<pcl::PointXYZRGBL>::Ptr localCloud, Eigen::Matrix4f transform );
    		pcl::PointCloud<pcl::PointXYZRGBL>::Ptr filterCloud(const pcl::PointCloud<pcl::PointXYZRGBL>::Ptr inputCloud, int n);
    		pcl::PointXYZ projectDepthTo3D(const cv::Mat depthImage, float x, float y, float cx, float cy,float fx, float fy );
    	public:
    		cloud(ros::NodeHandle *nh);
    		~cloud();
};

#endif
