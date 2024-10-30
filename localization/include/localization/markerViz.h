#ifndef MARKERVIZ_H_
#define MARKERVIZ_H_

#include <ros/ros.h>
#include <ros/console.h>
#include <visualization_msgs/Marker.h>
#include <localization/particle_msg.h>
#include <tf/LinearMath/Quaternion.h>
#include <move_base_msgs/MoveBaseActionGoal.h>

class markerViz
{
private:
    ros::Subscriber particleCloudSub_;
    ros::Subscriber goalSub_;
    ros::Publisher markerPub_;
    ros::Publisher goalMarkerPub_;
    void callback_(const localization::particle_msg::ConstPtr& msg);
    void goalCallback_(const move_base_msgs::MoveBaseActionGoal::ConstPtr& msg);
    void createMarker_(float x, float y, float yaw, float weight, int ID, float maxWeight);
    visualization_msgs::Marker marker_;
    visualization_msgs::Marker goalMarker_;
public:
    markerViz(ros::NodeHandle *nh);
    ~markerViz();
};

#endif