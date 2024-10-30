#include "targetClient.h"


targetClient::targetClient() : targetsClient_("move_base", true)
{
    this->goal_.target_pose.header.frame_id = "map";
    this->goal_.target_pose.pose.orientation.w = 1;
    while (!this->targetsClient_.waitForServer(ros::Duration(5.0))) ROS_INFO("Waiting for localization system to boot up");
}

targetClient::~targetClient()
{
}
// Method to set target coordinates and send a goal to the move_base action server
void targetClient::pathPlanUsingTargets(float X, float Y)
{
    this->goal_.target_pose.header.stamp = ros::Time::now();
    this->goal_.target_pose.pose.position.x = X;
    this->goal_.target_pose.pose.position.y = Y;
    
    ROS_INFO("Setting goal locations as X: %f, Y: %f", X, Y);
    this->targetsClient_.sendGoal(this->goal_);

    //Waiting for result removed until active testing
    ROS_INFO("Waiting for agent to reach target");
    this->targetsClient_.waitForResult();

    //Checking final state of the agent
    std::string result = (this->targetsClient_.getState() == actionlib::SimpleClientGoalState::SUCCEEDED) ? "Agent has reached target" : "Agent failed to reach target";
    ROS_INFO("%s", result.c_str());
}

// Main function to initialize the ROS node and send the target coordinates
int main(int argc, char** argv)
{
    ros::init(argc, argv, "target_client");
    targetClient* transmitter = new targetClient();
    transmitter->pathPlanUsingTargets(atof(argv[1]), atof(argv[2]));

    return 0;
}
