#include "markerViz.h"

markerViz::markerViz(ros::NodeHandle *nh)
{
    this->marker_.header.frame_id = "map";
    this->marker_.ns = "particle";
    this->goalMarker_.header.frame_id = "map";
    this->goalMarker_.ns = "goal";
    this->particleCloudSub_ = nh->subscribe("/clustered_particles", 10, &markerViz::callback_, this);
    this->goalSub_ = nh->subscribe("/move_base/goal", 10, &markerViz::goalCallback_, this);
    this->markerPub_ = nh->advertise<visualization_msgs::Marker>("/particle_markers", 10);
    this->goalMarkerPub_ =  nh->advertise<visualization_msgs::Marker>("/goal_marker", 10);
}

markerViz::~markerViz()
{
}

void markerViz::callback_(const localization::particle_msg::ConstPtr& msg)
{
    std::vector<float> weights;
    for (std::size_t i = 0; i < msg->data.size(); i++) weights.push_back(msg->data[i].w);
    float max = *std::max_element(weights.begin(), weights.end());
    this->marker_.header.stamp = ros::Time::now();
    for (std::size_t i = 0; i < msg->data.size(); i++)
    {
        this->createMarker_(msg->data[i].x, msg->data[i].y, msg->data[i].h, msg->data[i].w, (int)i, max);
        this->markerPub_.publish(this->marker_);
    }
}

void markerViz::goalCallback_(const move_base_msgs::MoveBaseActionGoal::ConstPtr& msg)
{
    this->goalMarker_.header.stamp = ros::Time::now();
    this->goalMarker_.id = 0;
    this->goalMarker_.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
    this->goalMarker_.action = visualization_msgs::Marker::ADD;
    this->goalMarker_.pose.position = msg->goal.target_pose.pose.position;
    this->goalMarker_.color.a = 1.0;
    this->goalMarker_.scale.x = 1;
    this->goalMarker_.scale.y = 1;
    this->goalMarker_.scale.z = 2.0f;
    this->goalMarker_.color.r = 1.0f;
    this->goalMarker_.color.g = 1.0f;
    this->goalMarker_.color.b = 1.0f;
    this->goalMarker_.text = "X";
    this->goalMarkerPub_.publish(this->goalMarker_);
}

void markerViz::createMarker_(float x, float y, float yaw, float weight, int ID, float maxWeight)
{
    this->marker_.id = ID;
    this->marker_.type = visualization_msgs::Marker::ARROW;
    this->marker_.action = visualization_msgs::Marker::ADD;
    this->marker_.pose.position.x = x / 10;
    this->marker_.pose.position.y = y / 10;
    this->marker_.pose.position.z = 0;
    tf::Quaternion q;
    q.setRPY(0.0, 0.0, yaw * 3.14 / 180);
    q.normalize();
    this->marker_.pose.orientation.x = q.getX();
    this->marker_.pose.orientation.y = q.getY();
    this->marker_.pose.orientation.z = q.getZ();
    this->marker_.pose.orientation.w = q.getW();
    this->marker_.scale.x = weight / maxWeight;
    this->marker_.scale.y = 0.1;
    this->marker_.scale.z = 0.1;
    this->marker_.color.a = 1.0;
    this->marker_.color.r = ((double) rand() / (RAND_MAX));
    this->marker_.color.g = ((double) rand() / (RAND_MAX));
    this->marker_.color.b = ((double) rand() / (RAND_MAX));
    this->marker_.lifetime = ros::Duration(0.5);
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "particle_markers");
    ros::NodeHandle nh;
    markerViz* markerViz_ = new markerViz(&nh);
    ros::spin();

    return 0;
}