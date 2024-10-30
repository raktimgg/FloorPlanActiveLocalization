#ifndef EXPLORATION_H_
#define EXPLORATION_H_

// C++ lib
#include<iostream>
#include<array>
#include<vector>
#include<string>
#include<math.h>
#include<cmath>
#include<algorithm>
#include <fstream>

// Ros lib
#include <ros/ros.h>
#include <ros/console.h>
#include<pcl/pcl_config.h>
#include <pcl/common/eigen.h>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <pcl/common/transforms.h>
#include <pcl_conversions/pcl_conversions.h>

// Ros Client Lib
#include <actionlib/client/simple_action_client.h>

// Ros Messages
#include "sem_cloud/particle_msg.h"
#include "sem_cloud/particle_struct.h"
#include "sem_cloud/MapGraph.h"
#include <move_base_msgs/MoveBaseAction.h>
#include <nav_msgs/Odometry.h>
#include <sensor_msgs/PointCloud2.h>
#include <std_msgs/Float64.h>
#include "sem_cloud/commandsafe.h"
// Transformation include files
#include <tf/transform_broadcaster.h>
#include <tf/tf.h>

using namespace std;


class explore
{
    private:

    sensor_msgs::PointCloud2ConstPtr localCloud;
    sensor_msgs::PointCloud2 localCloud_;
    sensor_msgs::PointCloud2ConstPtr cloud2D;
    sensor_msgs::PointCloud2 cloud2D_;
    sem_cloud::MapGraph mapGraph_;
    nav_msgs::Odometry odometry_msg;
    vector<vector<float>> permissible_space;
    vector<vector<float>> goal_locations;
    ros::Subscriber topParticles;
    ros::Subscriber mapGraph;
    actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>  explorePosition;
    move_base_msgs::MoveBaseGoal goal_;
    tf::TransformBroadcaster tf_broadcaster;
    tf::TransformBroadcaster static_broadcaster;
    Eigen::Matrix3f transform;
    void poseToTransform(geometry_msgs::Pose nodePose);
    sem_cloud::particle_struct particle;
    double previousTime ;
    ros::Publisher currentOdom;
    ros::Subscriber sCloud;
    ros::Subscriber sCloud2d;
    ros::Subscriber localization;
    ros::Publisher failSafe;

    Eigen::MatrixXf mH_c1_in_o;
    Eigen::MatrixXf zH_c1_in_o;
    int bad_;
    bool localized = false;
    bool first_mapgraph = false;
    

    

    public:

    explore(const ros::NodeHandle nh);
    
    void read_data(string loc, vector<vector<float>>& m);
    vector<float> rewardFunction(pcl::PointCloud<pcl::PointXYZRGBL>::Ptr currentCloud,sem_cloud::particle_struct position);
    void particlesCallback(sem_cloud::particle_msg msg);
    void poseCallback(sem_cloud::MapGraph msg);
    void poseCallback2(nav_msgs::Odometry msg);
    void cloudCallback(const sensor_msgs::PointCloud2ConstPtr& data);
    int check_permissible_space(float x_, float y_);
    void cloud2dCallback(const sensor_msgs::PointCloud2ConstPtr& data);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr transformCloud( pcl::PointCloud<pcl::PointXYZRGBL>::Ptr localCloud, Eigen::Matrix4f transform );
    Eigen::Matrix4f poseToTransform(sem_cloud::particle_struct msg);
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr nCloud; //(new pcl::PointCloud<pcl::PointXYZRGBL>);
    void localNotification(std_msgs::Float64 msg);

    Eigen::Matrix4f poseToTransform2(float w, float x, float y, float z, float pos_x, float pos_y);
    void mapgraph_zed_sync(const sem_cloud::MapGraphConstPtr& mapgraph_msg, const nav_msgs::OdometryConstPtr& zed_odom_msg);
    sem_cloud::particle_struct syncCallback_ZED(nav_msgs::Odometry data_pos, sensor_msgs::PointCloud2 data, sem_cloud::particle_struct top_particle);
    

};

#endif
