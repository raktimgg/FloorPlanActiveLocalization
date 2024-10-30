#include "voiceCommands_new.h"
#include <ros/ros.h>
#include <ros/console.h>
#include<fstream>
#include <nav_msgs/Path.h>
#include <nav_msgs/Odometry.h>
#include <iostream>
#include <array>

void voiceCommand::findTurns(nav_msgs::Path path)
{
    static int k = 0;

    std::ofstream myfile;
    myfile.open(std::to_string(k)+".csv");
    if(path.poses.size()!=0)
    {
        std::ofstream myfile;
        myfile.open(std::to_string(k)+".csv");
        voiceCommand::p.clear();
        voiceCommand::ap.clear();

        // Storing Point in a vector 
        for(int i = 0; i<path.poses.size();i++)
        {    
            p.push_back(cv::Point2f(path.poses[i].pose.position.x,path.poses[i].pose.position.y));   
            myfile << path.poses[i].pose.position.x << "," << path.poses[i].pose.position.y << "\n";
        }
        
        // Finding the points of turns
        cv::approxPolyDP( p, voiceCommand::ap, 0.8, false);
        int numTurns = voiceCommand::ap.size();
        //std::cout << "Number of turns found: " << numTurns << std::endl;
        // //std::cout<<"Points of turns in the path are : "<<voiceCommand::ap<<std::endl;
        myfile.close();
        k+=1;
    }
    

}

voiceCommand::voiceCommand(ros::NodeHandle *nh) //: sync(voiceCommand::syncPolicy(10), this->fSafe, this->fOdom)
{

    globalPlanner = nh->subscribe("/move_base/GlobalPlanner/plan",5,&voiceCommand::globalCallback,this);
    // localPlanner  = nh->subscribe("/move_base/TrajectoryPlannerROS/local_plan",5,&voiceCommand::localCallback,this);
    currentOdom = nh->subscribe("/current_odom",10,&voiceCommand::currentOdomCallback,this);
    command       = nh->advertise<std_msgs::String>("/commands",10);
}

void voiceCommand::currentOdomCallback(nav_msgs::Odometry data)
{
    //std::cout << "In H1 " << std::endl;
    nav_msgs::Odometry msg = data;
    static float lastOrientation = 0;
    std_msgs::String pubMsg;
    std::stringstream ss;
    voiceCommand::currentPose.pose = msg.pose;
    static double startTime = ros::Time::now().toSec();

    if(ros::Time::now().toSec()-startTime <100)
    {
        if(ap.size()>=3)
        {
            //Find distance from the next turn
            int distance  = std::pow(std::pow((msg.pose.pose.position.x-ap[1].x),2) + std::pow((msg.pose.pose.position.y-ap[1].y),2),0.5)*3.28084;
            
            //Calculate turn 
            int a = (ap[2].x-ap[0].x)*(ap[1].y-ap[0].y) - (ap[2].y-ap[0].y)*(ap[1].x-ap[0].x);
            //std::cout << "In H3 " << std::endl;
            std::string turn;
            
            // if(a<1)
            // {
            //     turn = "Left turn";

            // }
            // else
            // {
            //     turn = "Right turn";

            // }

            // Calculating the orientation and orientation change
            auto orientation1 = Eigen::Quaternionf(msg.pose.pose.orientation.w, msg.pose.pose.orientation.x, msg.pose.pose.orientation.y, msg.pose.pose.orientation.z).toRotationMatrix().eulerAngles(0,1,2);
            float changeOrientation = (orientation1[2]-lastOrientation)*180/3.14;
            
            if(distance<1.5*3.28084)
            {
                if(a<1)
                {
                    turn = "Left turn";

                }
                else
                {
                    turn = "Right turn";

                }
                ss << turn;
                pubMsg.data = ss.str();  
                //std::cout << "Command -  " << ss.str() << "\n"; 
                command.publish(pubMsg);
                return;

            }

            if(distance < 1.5*3.28084 && std::abs(changeOrientation) > 70)
            {
                // Removing the last position from the vector     
                voiceCommand::ap.erase(voiceCommand::ap.begin());

                lastOrientation = orientation1[2];
            }



        }
    }

    pubMsg.data = ss.str();  
    //std::cout << "Command -  " << ss.str() << "\n"; 
    command.publish(pubMsg);
    return;

}

void voiceCommand::globalCallback(nav_msgs::Path msg)
{
    //std::cout << "In H2 " << std::endl;
    int size = msg.poses.size();
    if(size!=0)
    {
        static double current_time = ros::Time::now().toSec();
        auto orientation_path = Eigen::Quaternionf(msg.poses[0].pose.orientation.w, msg.poses[0].pose.orientation.x, msg.poses[0].pose.orientation.y, msg.poses[0].pose.orientation.z).toRotationMatrix().eulerAngles(0,1,2);
        auto orientation_robot = Eigen::Quaternionf(voiceCommand::currentPose.pose.pose.orientation.w, voiceCommand::currentPose.pose.pose.orientation.x, voiceCommand::currentPose.pose.pose.orientation.y, voiceCommand::currentPose.pose.pose.orientation.z).toRotationMatrix().eulerAngles(0,1,2);
        int signMark = 0;
        if(orientation_path[2] < 0 && orientation_robot[2] < 0 && std::abs(orientation_path[2]) > 1 && std::abs(orientation_robot[2]) > 1)
        {
            orientation_path[2] = -orientation_path[2];
            orientation_robot[2] = -orientation_robot[2];
            signMark = 1;
        }

        float changeOrientation_rad_to_deg = std::abs((orientation_path[2]-orientation_robot[2])*(180)/3.14);
        //std::cout << "In changeOrientation_rad_to_deg " << changeOrientation_rad_to_deg << std::endl;
        std::string turn;
        // std::cout << "The change in orientation is: " << changeOrientation_rad_to_deg << std::endl;
        if(std::abs(changeOrientation_rad_to_deg) > 0 && ros::Time::now().toSec() - current_time > 4 )
        {
            // std::cout << "In H4 " << std::endl;
            std::cout << "Sign Mark " <<  signMark << std::endl;
            // std::cout << "orientation_path Angle: " << orientation_path << std::endl;
            // std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
            if(std::abs(changeOrientation_rad_to_deg) > 0 && std::abs(changeOrientation_rad_to_deg) < 40)
            {
                std::cout << "Go straight" << std::endl;
                std::cout << "In H5 " << std::endl;
                // //std::cout << "orientation_path Angle: " << orientation_path << std::endl;
                // //std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
                turn = " straight ";
            }
            else if(std::abs(changeOrientation_rad_to_deg) > 230 && std::abs(changeOrientation_rad_to_deg) < 330)
            {
                if (!signMark)
                {
                    std::cout << "Left turn" << std::endl;
                    std::cout << "In H6 " << std::endl;
                    std::cout << "orientation_path Angle: " << orientation_path << std::endl;
                    std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
                    turn = " Positive P - Left turn ";
                }
                else
                {
                    std::cout << "Right turn" << std::endl;
                    std::cout << "In H6 - Neg " << std::endl;
                    std::cout << "orientation_path Angle: " << orientation_path << std::endl;
                    std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
                    turn = " Negative P - Right turn ";
                }
            }
            else if(std::abs(changeOrientation_rad_to_deg) > 130 && std::abs(changeOrientation_rad_to_deg) < 220)
            {
                std::cout << "Take a u-turn" << std::endl;
                std::cout << "In H8 " << std::endl;
                std::cout << "orientation_path Angle: " << orientation_path << std::endl;
                std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
                turn = "Positive P - Take a u-turn";
            }
            else if(std::abs(changeOrientation_rad_to_deg) > 40 && std::abs(changeOrientation_rad_to_deg) < 130)
            {
                if (!signMark)
                {
                    std::cout << "Right turn" << std::endl;
                    std::cout << "In H7 " << std::endl;
                    std::cout << "orientation_path Angle: " << orientation_path << std::endl;
                    std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
                    turn = " Positive P - Right turn ";
                }
                else
                {
                    std::cout << "Left turn" << std::endl;
                    std::cout << "In H7 - Neg " << std::endl;
                    std::cout << "orientation_path Angle: " << orientation_path << std::endl;
                    std::cout << "orientation_robot Angle: " << orientation_robot << std::endl;
                    turn = " Negative P - Left turn ";
                }

            }

            

            current_time = ros::Time::now().toSec();
  	        std_msgs::String pubMsg;
    	    std::stringstream ss;  
            ss << turn; 

            pubMsg.data = ss.str();    
            command.publish(pubMsg); 
        }

        findTurns(msg);

    }

}


int main(int argc, char **argv)
{
    ros::init(argc,argv,"commandsNode_new");
    ros::NodeHandle nh;
    voiceCommand* sem_cloud = new voiceCommand(&nh);
    ros::spin();
    return 0;
}