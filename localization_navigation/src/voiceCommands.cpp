#include <ros/ros.h>
#include <ros/console.h>

// Message include files 
#include <nav_msgs/Path.h>
#include <nav_msgs/Odometry.h>
#include <iostream>
#include <array>


class voiceCommand
{
    private:
    ros::Publisher command;

    ros::Subscriber globalPlanner;
    void globalCallback(nav_msgs::Path);

    ros::Subscriber localPlanner;
    void localCallback(nav_msgs::Path);


    public:
    voiceCommand(ros::NodeHandle *nh);

};
// Callback function for handling local path messages
voiceCommand::voiceCommand(ros::NodeHandle *nh)
{

    globalPlanner = nh->subscribe("/move_base/GlobalPlanner/plan",10,&voiceCommand::globalCallback,this);
    localPlanner = nh->subscribe("/move_base/TrajectoryPlannerROS/local_plan",10,&voiceCommand::localCallback,this);

}
// Callback function for handling global path messages
void voiceCommand::globalCallback(nav_msgs::Path msg)
{

 //ROS_INFO("Recieved a global path message and length of path is %d", msg.poses.size());
 
}

void voiceCommand::localCallback(nav_msgs::Path msg)
{
 ROS_INFO("Recieved a Local path message and length of path is %d ", msg.poses.size());
 
}
// Main function to initialize the ROS node and spin
int main(int argc, char **argv)
{
    ros::init(argc,argv,"commandsNode");
    ros::NodeHandle nh;
    voiceCommand sem_cloud = voiceCommand(&nh);
    ros::spin();
    return 0;
}
