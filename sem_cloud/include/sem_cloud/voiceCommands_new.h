#ifndef VOICECOMMANDS_H_
#define VOICECOMMANDS_H_

//C++ libraaries
#include<iostream>
#include<array>
#include<vector>
#include<string>

//Opencv Libraries
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>


// ROS libraries 
#include <ros/ros.h>
#include <ros/console.h>

// Message include files 
#include <nav_msgs/Path.h>
#include <nav_msgs/Odometry.h>
#include <std_msgs/String.h>
#include "sem_cloud/commandsafe.h"


// Message filter include files
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include<message_filters/time_synchronizer.h>

// Eigen 
#include <pcl/common/eigen.h>


class voiceCommand
{
    private:
    ros::Publisher command;
    nav_msgs::Path turns;
    nav_msgs::Path smallPath;
    nav_msgs::Odometry currentPose;
    std::string local;


    // message_filters::Subscriber<sem_cloud::commandsafe> fSafe ;
    // message_filters::Subscriber<nav_msgs::Odometry> fOdom;
    // typedef message_filters::sync_policies::ApproximateTime<sem_cloud::commandsafe,nav_msgs::Odometry> syncPolicy;
    // message_filters::Synchronizer<voiceCommand::syncPolicy> sync;

    ros::Subscriber globalPlanner;
    ros::Subscriber failsafe;
    ros::Subscriber currentOdom;
    sem_cloud::commandsafe safeMoves;
    void globalCallback(nav_msgs::Path);
    ros::Subscriber localPlanner;
    void localCallback(nav_msgs::Path);
    ros::Subscriber pose;
    void poseCallback(nav_msgs::Odometry msg);
    void currentOdomCallback(nav_msgs::Odometry);

    std::vector<cv::Point2f> p, ap;
    void failCommands(sem_cloud::commandsafe msg);


    public:
    voiceCommand(ros::NodeHandle *nh);
    float calculateDistance(geometry_msgs::PoseStamped position1, geometry_msgs::PoseStamped position2);
    void findTurns(nav_msgs::Path path);
    void syncCallback(const sem_cloud::commandsafe::ConstPtr& Fmsg, const nav_msgs::Odometry::ConstPtr& msg);
};

#endif
