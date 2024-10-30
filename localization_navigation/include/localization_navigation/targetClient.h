#ifndef TARGETCLIENT_H_
#define TARGETCLIENT_H_

#include <ros/ros.h>
#include <ros/console.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>


class targetClient
{
private:
    actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> targetsClient_;
    move_base_msgs::MoveBaseGoal goal_;
public:
    targetClient();
    ~targetClient();
    void pathPlanUsingTargets(float X, float Y);
};

#endif