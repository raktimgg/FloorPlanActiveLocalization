#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/PoseStamped.h>
#include <sensor_msgs/FluidPressure.h>

class pub_sub
{
	public:
	pub_sub(ros::NodeHandle *nh);
	void zedodomCallback(nav_msgs::Odometry msg);
	void zedposeCallback(geometry_msgs::PoseStamped msg);
	void zedpressureCallback(sensor_msgs::FluidPressure msg);
	private:
	ros::Publisher odom_;
	ros::Subscriber zed_odom;
	ros::Subscriber zed_pose;
	ros::Subscriber zed_pressure;
	geometry_msgs::PoseStamped current_pose;
	nav_msgs::Odometry current_odom;
	int counter = 0; 
	tf::TransformBroadcaster odom_broadcaster;	
	double current_pressure=0;
	int initial_pressure=0;
	int firstReading = 0;
	int pressure_difference;
	float z;
	std::vector<double> zValues;
	//gram_sg::SavitzkyGolayFilter filter;
};

// Constructor to initialize publishers and subscribers
pub_sub::pub_sub(ros::NodeHandle *nh)// : filter(3, 2, 20, 0)
{
	odom_        = nh->advertise<nav_msgs::Odometry>("zed2/zed_node/odom_correct",50);
	zed_odom     = nh->subscribe("zed2/zed_node/odom",200,&pub_sub::zedodomCallback, this);
	zed_pose     = nh->subscribe("zed2/zed_node/pose",200,&pub_sub::zedposeCallback, this);
	zed_pressure = nh->subscribe("zed2/zed_node/atm_press",200,&pub_sub::zedpressureCallback, this);
}

// Callback function for odometry messages
void pub_sub::zedodomCallback(nav_msgs::Odometry msg)
{
	// Z-direction calculation 
	this->z = -(pressure_difference)/(1.2*9.81);
	ROS_INFO("Z difference is %f", this->z);
	current_odom = msg;

	// Create and send transform
	geometry_msgs::TransformStamped transform;
	transform.header.frame_id = "odom2";
	transform.child_frame_id = "base_link";
	transform.header.stamp = msg.header.stamp;
	transform.transform.translation.x = msg.pose.pose.position.x;
	transform.transform.translation.y = msg.pose.pose.position.y;
	transform.transform.translation.z = this->z;
	transform.transform.rotation = msg.pose.pose.orientation;	
	odom_broadcaster.sendTransform(transform);
	
	// Create and publish corrected odometry message
	nav_msgs::Odometry pub_odom;
	pub_odom.header.stamp = msg.header.stamp;
	pub_odom.header.frame_id = "odom2";
	pub_odom.child_frame_id  = "base_link";
	pub_odom.pose.pose.position.x = msg.pose.pose.position.x;
	pub_odom.pose.pose.position.y = msg.pose.pose.position.y;
	pub_odom.pose.pose.position.z = this->z;
	pub_odom.pose.pose.orientation = msg.pose.pose.orientation;
	pub_odom.pose.covariance = msg.pose.covariance;
	pub_odom.twist.twist.linear.x = msg.twist.twist.linear.x;
	pub_odom.twist.twist.linear.y = msg.twist.twist.linear.y;
	pub_odom.twist.twist.angular.z = msg.twist.twist.linear.z;
	odom_.publish(pub_odom);
}

// Callback function for pressure messages
void pub_sub::zedpressureCallback(sensor_msgs::FluidPressure msg)
{
	static int count = 0;
	// Save initial pressure
	if(count == 0) {
		initial_pressure = msg.fluid_pressure;
		count = 1;
	}
	current_pressure = msg.fluid_pressure;
	pressure_difference = current_pressure - initial_pressure;
}

// Callback function for pose messages
void pub_sub::zedposeCallback(geometry_msgs::PoseStamped msg)
{
	current_pose = msg;
	counter = 1;
}

int main(int argc, char **argv)
{
	ros::init(argc,argv,"odom_correction");
	ros::NodeHandle nh;
	pub_sub sem_cloud = pub_sub(&nh);
	ros::spin();
	return 0;
}
