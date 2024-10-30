#include "exploration.h"

#include <iostream>
#include <cmath>
#include <fstream>
#include <vector>
#include <sstream>
#include <string>
#include <math.h>
#include <random>
#include <algorithm>
#include <numeric>
#include <cstdlib>
#include <iterator>
#include <list>

#include "maze.cpp"
#include <ros/ros.h>

// Ros Message Include files
#include <sensor_msgs/PointCloud2.h>
#include <sem_cloud/MapGraph.h>
#include <sem_cloud/robot_struct.h>
#include <sem_cloud/topParticle.h>
#include <nav_msgs/Odometry.h>

#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <std_msgs/Float64MultiArray.h>
#include <pcl_ros/point_cloud.h>
#include <pcl/PCLPointCloud2.h>
#include <pcl/point_types.h>
#include <boost/foreach.hpp>
#include <sensor_msgs/point_cloud_conversion.h>
#include <sensor_msgs/point_cloud2_iterator.h>
#include <pcl/pcl_config.h>
#include <pcl_conversions/pcl_conversions.h>

vector<vector<float>> pos_space;
vector<vector<float>> corner_pos;
vector<vector<float>> doors;
vector<vector<float>> walls;
sem_cloud::commandsafe msgCommand;

float e;

void read_data(string loc, vector<vector<float>> &m)
{
    ifstream is(loc);
    string line;
    float word;
    while (getline(is, line, '\n'))
    {
        vector<float> tempVec;
        istringstream ss(line);
        while (ss >> word)
        {
            tempVec.push_back(word);
        }
        m.emplace_back(tempVec);
    }
}

float get_yaw(float q3, float q2, float q1, float q0)
{
    float yaw;
    yaw = atan2(2 * (q0 * q1 + q2 * q3), 1 - 2 * (q1 * q1 + q2 * q2)) * 180 / 3.14159;

    return yaw;
}

void mat_mul_3x3(float A[3][3], float B[3][3], float product[3][3])
{
    int i, j, k;
    int r1 = 3;
    int c1 = 3;
    int r2 = 3;
    int c2 = 3;
    // float product[r1][c2];
    for (i = 0; i < r1; ++i)
    {
        for (j = 0; j < c2; ++j)
        {
            product[i][j] = 0;
        }
    }

    for (i = 0; i < r1; ++i)
    {
        for (j = 0; j < c2; ++j)
        {
            for (k = 0; k < c1; ++k)
            {
                product[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

vector<size_t> sort_indexes(const vector<float> &v)
{

    // initialize original index locations
    vector<size_t> idx(v.size());
    iota(idx.begin(), idx.end(), 0);

    // sort indexes based on comparing values in v
    // using std::stable_sort instead of std::sort
    // to avoid unnecessary index re-orderings
    // when v contains elements of equal values
    stable_sort(idx.begin(), idx.end(),
                [&v](size_t i1, size_t i2)
                { return v[i1] < v[i2]; });

    return idx;
}

// This function generates a set of local particles around a given transformation matrix H.
// The particles are initialized at positions in pos_space that are closest to the coordinates
// specified by the transformation matrix H, with some added noise to their headings.
vector<Particles> get_local_particles(float H[3][3], vector<vector<float>> pos_space, vector<vector<float>> corner_pos)
{
    int ind = 0;

    // Extract the x, y coordinates and heading from the transformation matrix H
    float x = H[0][2];
    float y = H[1][2];
    float h = atan2(H[1][0], H[0][0]) * 180 / 3.14159;

    // Initialize random number generator and normal distribution
    default_random_engine generator;
    normal_distribution<float> distribution(0.0, 5.0);

    vector<float> a;

    // Calculate the distance from each position in pos_space to the given x, y coordinates
    for (int i = 0; i < pos_space.size(); i++)
    {
        float xi = pos_space[i][0];
        float yi = pos_space[i][1];
        float dist = sqrt(pow((x - xi), 2) + pow((y - yi), 2));
        a.push_back(dist);
    }

    // Sort the positions based on their distances
    vector<size_t> arg = sort_indexes(a);
    vector<Particles> res;

    // Select the closest 150 positions and initialize particles at those positions
    for (int i = 0; i < 150; i++)
    {
        Particles tempPart;
        float x_ = pos_space[arg[i]][0];
        float y_ = pos_space[arg[i]][1];
        float h_ = h + distribution(generator); // Add some noise to the heading
        
        tempPart.initialize(x_, y_, h_);
        res.push_back(tempPart);
    }

    return res;
}

// Function to remove redundant landmarks from a list of landmarks
vector<vector<float>> remove_redundancies_from_landmarks(vector<vector<float>> landmarks)
{
    // Sort the landmarks
    sort(landmarks.begin(), landmarks.end());
    // Remove duplicates
    landmarks.erase(unique(landmarks.begin(), landmarks.end()), landmarks.end());
    return landmarks;
}

// Function to find the nearest door to a given point (x, y)
float find_nearest_door(float x, float y, float x1, float y1, float x2, float y2)
{
    float A = x - x1;
    float B = y - y1;
    float C = x2 - x1;
    float D = y2 - y1;

    float dot = A * C + B * D;
    float len_sq = C * C + D * D;
    float param = -1;
    float xx;
    float yy;

    // Calculate the projection of the point onto the line segment
    if (len_sq != 0)
        param = dot / len_sq;

    // Determine the nearest point on the line segment
    if (param < 0)
    {
        xx = x1;
        yy = y1;
    }
    else if (param > 1)
    {
        xx = x2;
        yy = y2;
    }
    else
    {
        xx = x1 + param * C;
        yy = y1 + param * D;
    }

    // Calculate the distance between the point and the nearest point on the line segment
    float dx = x - xx;
    float dy = y - yy;
    return sqrt(dx * dx + dy * dy);
}

// Function to find the minimum value in an array
float find_min(float arr[], int N)
{
    float min = INT_MAX;
    for (int i = 0; i < N; i++)
    {
        if (arr[i] < min)
        {
            min = arr[i];
        }
    }
    return min;
}

// Function to calculate the distance from a point to the nearest wall
float d(float p[2], vector<vector<float>> walls)
{
    float x = p[0];
    float y = p[1];
    float x1, x2, y1, y2;
    float dist[walls.size()];

    // Calculate the distance from the point to each wall
    for (int i = 0; i < walls.size(); i++)
    {
        x1 = walls[i][0];
        y1 = walls[i][1];
        x2 = walls[i][2];
        y2 = walls[i][3];
        dist[i] = find_nearest_door(x, y, x1, y1, x2, y2);
    }

    // Return the minimum distance
    return find_min(dist, walls.size());
}

// Function to calculate the weight of a particle based on its alignment with observed landmarks.
// The weight is determined by the distance between the transformed landmarks and the known landmarks.
float find_weight(float H[3][3], vector<vector<float>> landmarks_doors, vector<vector<float>> landmarks_walls, vector<vector<float>> doors, vector<vector<float>> walls)
{
    float wi_doors = 0;
    float wi_walls = 0;
    float wall_ratio = 0.6;

    // Calculate the weight contribution from door landmarks
    for (int i = 0; i < landmarks_doors.size(); i++)
    {
        float p1[3] = {landmarks_doors[i][0], landmarks_doors[i][1], 1};
        float points_w[2] = {H[0][0] * p1[0] + H[0][1] * p1[1] + H[0][2] * p1[2],
                             H[1][0] * p1[0] + H[1][1] * p1[1] + H[1][2] * p1[2]};

        wi_doors += d(points_w, doors);
    }

    // Calculate the weight contribution from wall landmarks
    for (int i = 0; i < landmarks_walls.size(); i++)
    {
        float p1[3] = {landmarks_walls[i][0], landmarks_walls[i][1], 1};
        float points_w[2] = {H[0][0] * p1[0] + H[0][1] * p1[1] + H[0][2] * p1[2],
                             H[1][0] * p1[0] + H[1][1] * p1[1] + H[1][2] * p1[2]};

        wi_walls += d(points_w, walls);
    }

    // Calculate the final weight by combining the contributions from doors and walls
    float wi = /*wall_ratio*/ wi_walls / landmarks_walls.size(); //+ (1-wall_ratio)*wi_doors/landmarks_doors.size() ;
    // float wi = (1-wall_ratio)*wi_doors/landmarks_doors.size();
    // float wi = (1-wall_ratio)*wi_doors + wall_ratio*wi_walls;
    return 1 / wi;
}

// This function arranges particles based on their weights in descending order
// and returns the top 'n' particles with the highest weights.
vector<Particles> arange_particles(vector<Particles> particles, int n)
{
    vector<float> a;

    // Collect weights of all particles
    for (int i = 0; i < particles.size(); i++)
    {
        a.push_back(particles[i].weight);
    }

    // Sort indexes based on weights
    vector<size_t> arg = sort_indexes(a);
    vector<Particles> res;

    // Select the top 'n' particles with the highest weights
    for (int i = 0; i < n; i++)
    {
        res.push_back(particles[arg[arg.size() - i - 1]]);
    }
    return res;
}

// This function checks if a given (x_, y_) position is within the permissible space.
// It returns 1 if the position is permissible, otherwise returns 0.
int check_permissible_space(float x_, float y_, vector<vector<float>> pos_space)
{
    x_ = round(x_);
    y_ = round(y_);
    vector<float> temp;
    temp.push_back(x_);
    temp.push_back(y_);

    // Check if the position exists in the permissible space
    if (count(pos_space.begin(), pos_space.end(), temp))
    {
        return 1;
    }
    return 0;
}

// This function performs a special resampling of particles based on their weights.
// It selects the top 'n' particles with the highest weights and generates new particles
// around these top particles by adding some noise to their positions and headings.
vector<Particles> special_resample_particles(vector<Particles> particles, vector<vector<float>> pos_space)
{
    int n = 5; // Number of top particles to select
    int N = particles.size(); // Total number of particles
    vector<Particles> top_n_particles;
    top_n_particles = arange_particles(particles, n); // Select top 'n' particles based on weights

    float x_, y_, h_;
    int k;
    default_random_engine generator;
    normal_distribution<float> distribution(0.0, 10.0); // Normal distribution for noise
    particles.clear(); // Clear the original particles

    // Generate new particles around the top 'n' particles
    for (int i = 0; i < top_n_particles.size(); i++)
    {
        k = 0;
        while (k < 4) // Generate 4 new particles for each top particle
        {
            k += 1;
            x_ = top_n_particles[i].x + distribution(generator); // Add noise to x position
            y_ = top_n_particles[i].y + distribution(generator); // Add noise to y position
            h_ = top_n_particles[i].heading + distribution(generator) / 3; // Add noise to heading

            // Ensure the new position is within the permissible space
            while (check_permissible_space(x_, y_, pos_space) != 1)
            {
                x_ = top_n_particles[i].x;
                y_ = top_n_particles[i].y;
            }

            Particles tempPart;
            tempPart.initialize(x_, y_, h_); // Initialize the new particle
            particles.push_back(tempPart); // Add the new particle to the list
        }
    }
    return particles; // Return the new set of particles
}


// This function identifies the best particle from a set of particles based on their alignment with observed landmarks.
// It processes the point cloud data to extract door and wall landmarks, calculates the weight of each particle,
// and returns the particle with the highest weight.
Particles get_best_particle(vector<Particles> particles, sensor_msgs::PointCloud2 data, vector<vector<float>> doors, vector<vector<float>> walls, vector<vector<float>> pos_space)
{
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr nCloud(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::fromROSMsg(data, *nCloud);
    vector<vector<float>> landmarks_doors;
    vector<vector<float>> landmarks_walls;
    vector<vector<float>> landmarks_final;

    // Extract door and wall landmarks from the point cloud data
    for (pcl::PointCloud<pcl::PointXYZRGBL>::iterator it = nCloud->begin(); it != nCloud->end(); ++it)
    {
        if (it->label == 14 && it->z >= 0.5 && it->z <= 2.2)
        {
            vector<float> temp;
            temp.push_back(round(it->x * 10));
            temp.push_back(round(it->y * 10));
            landmarks_doors.push_back(temp);
            landmarks_final.push_back(temp);
        }
        else if (it->label == 0 && it->z >= -0.2 && it->z <= 0.9)
        {
            vector<float> temp;
            temp.push_back(round(it->x * 10));
            temp.push_back(round(it->y * 10));
            landmarks_walls.push_back(temp);
            landmarks_final.push_back(temp);
        }
    }

    // Remove redundant landmarks
    landmarks_doors = remove_redundancies_from_landmarks(landmarks_doors);
    landmarks_walls = remove_redundancies_from_landmarks(landmarks_walls);
    landmarks_final = remove_redundancies_from_landmarks(landmarks_final);

    int NumIter = 1;
    int aa = 0;
    while (aa < NumIter)
    {
        // Calculate the weight of each particle based on its alignment with the landmarks
        for (int i = 0; i < particles.size(); i++)
        {
            float xp = particles[i].x;
            float yp = particles[i].y;
            float headingp = particles[i].heading * 3.14159 / 180;
            float H_p_in_w[3][3] = {{cos(headingp), -sin(headingp), xp},
                                    {sin(headingp), cos(headingp), yp},
                                    {0, 0, 1}};

            float weight = find_weight(H_p_in_w, landmarks_doors, landmarks_walls, doors, walls);
            particles[i].weight = weight;
        }

        // Perform special resampling if not the last iteration
        if (aa != NumIter - 1)
            particles = special_resample_particles(particles, pos_space);
        aa += 1;
    }

    // Identify the particle with the highest weight
    float big = -1;
    int ind = 0;
    for (int i = 0; i < particles.size(); i++)
    {
        float weight = particles[i].weight;
        if (weight >= big)
        {
            big = weight;
            ind = i;
        }
    }

    return particles[ind];
}

// This function synchronizes the ZED camera's odometry data with the top particle's pose.
// It calculates the transformation matrix between the ZED camera and the world frame,
// updates the agent's pose, and returns the current pose of the particle with the highest weight.
sem_cloud::particle_struct explore::syncCallback_ZED(nav_msgs::Odometry data_pos, sensor_msgs::PointCloud2 data, sem_cloud::particle_struct top_particle)
{
    float yaw;

    // Extract the top particle's position and heading
    float xtp = top_particle.x;
    float ytp = top_particle.y;
    float headingtp = top_particle.h * 3.14159 / 180;
    float H_p_in_w[3][3] = {{cos(headingtp), -sin(headingtp), xtp},
                            {sin(headingtp), cos(headingtp), ytp},
                            {0, 0, 1}};

    // Extract the ZED camera's position and orientation from the odometry data
    float trans_x = data_pos.pose.pose.position.x;
    float trans_y = data_pos.pose.pose.position.y;
    float trans_z = data_pos.pose.pose.position.z;

    float quat_x = data_pos.pose.pose.orientation.x;
    float quat_y = data_pos.pose.pose.orientation.y;
    float quat_z = data_pos.pose.pose.orientation.z;
    float quat_w = data_pos.pose.pose.orientation.w;

    // Calculate the yaw angle based on the transformation matrix
    if(explore::first_mapgraph)
    {
        Eigen::MatrixXf zH_c2_in_o = explore::poseToTransform2(quat_w,quat_x,quat_y,quat_z,trans_x,trans_y);
        
        Eigen::MatrixXf mH_c2_in_o = explore::mH_c1_in_o * (explore::zH_c1_in_o.inverse()*zH_c2_in_o);

        yaw = atan2(mH_c2_in_o(1,0),mH_c2_in_o(0,0))*180/3.14;
    }
    else
    {
        yaw = get_yaw(quat_x, quat_y, quat_z, quat_w);
    }

    // Calculate the transformation matrix from the robot frame to the particle frame
    float xr1 = trans_x * 10;
    float yr1 = trans_y * 10;
    float headingr1 = yaw * 3.14159 / 180;
    float H_r_in_p[3][3] = {{cos(headingr1), -sin(headingr1), xr1},
                            {sin(headingr1), cos(headingr1), yr1},
                            {0, 0, 1}};

    // Calculate the transformation matrix from the robot frame to the world frame
    float H_r_in_w[3][3];
    mat_mul_3x3(H_p_in_w, H_r_in_p, H_r_in_w);

    // Generate local particles around the transformation matrix
    vector<Particles> local_particles = get_local_particles(H_r_in_w, pos_space, corner_pos);

    // Identify the best particle based on the point cloud data
    Particles best_part;
    best_part = get_best_particle(local_particles, data, doors, walls, pos_space);

    // Update the current pose with the best particle's position and heading
    sem_cloud::particle_struct current_pose;
    current_pose.x = best_part.x;
    current_pose.y = best_part.y;
    current_pose.h = best_part.heading;
    current_pose.w = best_part.weight;

    return current_pose;
}

// Function for creation of transformation matrix from particle_struct
// This function takes a particle_struct message and converts it into a 4x4 transformation matrix.
// The transformation matrix represents the position and orientation of the particle in the world frame.
Eigen::Matrix4f explore::poseToTransform(sem_cloud::particle_struct msg)
{
    float theta = msg.h * 3.14 / 180; // Convert heading from degrees to radians
    Eigen::Matrix4f transformation;
    transformation << cos(theta), -sin(theta), 0, msg.x,
                      sin(theta), cos(theta), 0, msg.y,
                      0, 0, 1, 0,
                      0, 0, 0, 1;
    return transformation;
}

// Function to transform the position of a point cloud
// This function takes a local point cloud and a transformation matrix, and applies the transformation
// to the point cloud. It returns the transformed point cloud.
pcl::PointCloud<pcl::PointXYZRGBL>::Ptr explore::transformCloud(pcl::PointCloud<pcl::PointXYZRGBL>::Ptr localCloud, Eigen::Matrix4f transform)
{
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output(new pcl::PointCloud<pcl::PointXYZRGBL>);
    output->resize(localCloud->size());
    pcl::transformPointCloud(*localCloud, *output, transform);

    return output;
}

// Function for creation of transformation matrix from quaternion and position
// This function takes a quaternion (w, x, y, z) and a position (pos_x, pos_y), and converts them
// into a 4x4 transformation matrix. The transformation matrix represents the position and orientation
// of the object in the world frame.
Eigen::Matrix4f explore::poseToTransform2(float w, float x, float y, float z, float pos_x, float pos_y)
{
    auto rotation = Eigen::Quaternionf(w, x, y, z).toRotationMatrix().eulerAngles(0, 1, 2);
    Eigen::Matrix4f trans_mat;
    trans_mat << cos(rotation(0, 0)), -sin(rotation(0, 0)), pos_x,
                 sin(rotation(0, 0)), cos(rotation(0, 0)), pos_y,
                 0, 0, 1;
    return trans_mat;
}

// This function synchronizes the MapGraph and ZED odometry messages.
// It extracts the transformation matrices from the MapGraph and ZED odometry messages
// and updates the transformation matrices used for localization.
void explore::mapgraph_zed_sync(const sem_cloud::MapGraphConstPtr& mapgraph_msg, const nav_msgs::OdometryConstPtr& zed_odom_msg)
{
    float w, x, y, z, pos_x, pos_y;
    int sz = mapgraph_msg->poses.size();
    
    // Extract the transformation matrix from the MapGraph message
    w = mapgraph_msg->poses[sz - 1].orientation.w;
    x = mapgraph_msg->poses[sz - 1].orientation.x;
    y = mapgraph_msg->poses[sz - 1].orientation.y;
    z = mapgraph_msg->poses[sz - 1].orientation.z;
    pos_x = mapgraph_msg->poses[sz - 1].position.x;
    pos_y = mapgraph_msg->poses[sz - 1].position.y;
    mH_c1_in_o = explore::poseToTransform2(w, x, y, z, pos_x, pos_y);

    // Extract the transformation matrix from the ZED odometry message
    w = zed_odom_msg->pose.pose.orientation.w;
    x = zed_odom_msg->pose.pose.orientation.x;
    y = zed_odom_msg->pose.pose.orientation.y;
    z = zed_odom_msg->pose.pose.orientation.z;
    pos_x = zed_odom_msg->pose.pose.position.x;
    pos_y = zed_odom_msg->pose.pose.position.y;
    zH_c1_in_o = explore::poseToTransform2(w, x, y, z, pos_x, pos_y);

    explore::first_mapgraph = true;
}

// Constructor for the explore class.
// It initializes the ROS subscribers, publishers, and message filters.
// It also reads data from files to initialize various data structures.
explore::explore(ros::NodeHandle nh) : explorePosition("move_base", true)
{
    topParticles = nh.subscribe("/clustered_particles", 10, &explore::particlesCallback, this);
    mapGraph = nh.subscribe("/zed2/zed_node/odom_correct", 10, &explore::poseCallback2, this);

    sCloud = nh.subscribe("/sync/local_cloud", 10, &explore::cloudCallback, this);
    sCloud2d = nh.subscribe("/pcl_2d", 5, &explore::cloud2dCallback, this);
    localization = nh.subscribe("/loc_percentage", 5, &explore::localNotification, this);
    currentOdom = nh.advertise<nav_msgs::Odometry>("/current_odom", 10);
    failSafe = nh.advertise<sem_cloud::commandsafe>("/fail_safe", 10);

    message_filters::Subscriber<sem_cloud::MapGraph> mapgraphCallback_sub(nh, "/rtabmap/mapGraph", 1);
    message_filters::Subscriber<nav_msgs::Odometry> zedCallback_sub(nh, "/zed2/zed_node/odom_correct", 1);
    message_filters::TimeSynchronizer<sem_cloud::MapGraph, nav_msgs::Odometry> sync2(mapgraphCallback_sub, zedCallback_sub, 10);
    sync2.registerCallback(boost::bind(&explore::mapgraph_zed_sync, this, _1, _2));

    read_data("/home/crrl/crrl_ws/src/localization/src/CPP/permissible_space4.txt", pos_space);
    read_data("/home/crrl/crrl_ws/src/localization/src/CPP/doors_walls/walls.txt", walls);
    read_data("/home/crrl/crrl_ws/src/localization/src/CPP/doors_walls/doors.txt", doors);
    read_data("/home/crrl/crrl_ws/src/localization/src/CPP/permissible_space.txt", permissible_space);
    read_data("/home/crrl/crrl_ws/src/sem_cloud/include/goal_rewards.txt", explore::goal_locations);

    this->goal_.target_pose.header.frame_id = "map";
    this->goal_.target_pose.pose.orientation.w = 1;
    bad_ = 0;
}

// This function handles localization notifications.
// When a localization notification with data value 1 is received,
// it sets a target position and sends a goal to the explorePosition action client.
void explore::localNotification(std_msgs::Float64 msg)
{
    if (msg.data == 1)
    {
        // Set target position
        this->goal_.target_pose.header.stamp = ros::Time::now();
        this->goal_.target_pose.pose.position.x = 41 / 10;
        this->goal_.target_pose.pose.position.y = 50 / 10;

        this->explorePosition.sendGoal(this->goal_);
    }
}

// This function handles the callback for the local point cloud data.
// It updates the localCloud and localCloud_ member variables with the received data.
void explore::cloudCallback(const sensor_msgs::PointCloud2ConstPtr &data)
{
    this->explore::localCloud = data;
    explore::localCloud_ = *data;
}

// This function handles the callback for the 2D point cloud data.
// It updates the cloud2D and cloud2D_ member variables with the received data.
// It also converts the received data to a pcl::PointCloud and stores it in nCloud.
void explore::cloud2dCallback(const sensor_msgs::PointCloud2ConstPtr &data)
{
    this->explore::cloud2D = data;
    explore::cloud2D_ = *data;
    pcl::PointCloud<pcl::PointXYZRGBL>::Ptr output_filtered(new pcl::PointCloud<pcl::PointXYZRGBL>);
    pcl::fromROSMsg(*data, *output_filtered);
    explore::nCloud = output_filtered;
}

// This function checks if a given (x_, y_) position is within the permissible space.
// It returns 1 if the position is permissible, otherwise returns 0.
int explore::check_permissible_space(float x_, float y_)
{
    x_ = round(x_);
    y_ = round(y_);
    vector<float> temp;
    temp.push_back(x_);
    temp.push_back(y_);
    if (count(permissible_space.begin(), permissible_space.end(), temp))
    {
        return 1;
    }
    return 0;
}

// This function converts a geometry_msgs::Pose message to a 3x3 transformation matrix.
// The transformation matrix represents the position and orientation of the node in the world frame.
void explore::poseToTransform(geometry_msgs::Pose nodePose)
{
    auto rotation = Eigen::Quaternionf(nodePose.orientation.w, nodePose.orientation.x, nodePose.orientation.y, nodePose.orientation.z).toRotationMatrix().eulerAngles(0, 1, 2);

    this->explore::transform << cos(rotation(0, 0)), -sin(rotation(0, 0)), nodePose.position.x * 10,
        sin(rotation(0, 0)), cos(rotation(0, 0)), nodePose.position.y * 10,
        0, 0, 1;
}
// This function handles the callback for the ZED odometry data.
// It updates the transformation matrix based on the received odometry data,
// synchronizes the ZED camera's odometry with the top particle's pose,
// and publishes the updated transformation and odometry information.
void explore::poseCallback2(nav_msgs::Odometry msg)
{
    Eigen::MatrixXf v(3, 1);
    Eigen::MatrixXf particle_current(3, 1);
    explore::poseToTransform(msg.pose.pose);
    
    v << explore::particle.x,
        explore::particle.y,
        1;
    particle_current = explore::transform * v;
    explore::odometry_msg = msg;

    sem_cloud::particle_struct w_pos = explore::syncCallback_ZED(explore::odometry_msg, explore::localCloud_, explore::particle);
 
    tf::Quaternion q;
    q.setRPY(0, 0, w_pos.h * 3.14159 / 180);
    
    geometry_msgs::TransformStamped transform;
    transform.header.frame_id = "map";
    transform.child_frame_id = "agent_base";
    transform.header.stamp = ros::Time::now();
    transform.transform.translation.x = w_pos.x / 10;
    transform.transform.translation.y = w_pos.y / 10;
    transform.transform.translation.z = 0;
    transform.transform.rotation.x = q.x();
    transform.transform.rotation.y = q.y();
    transform.transform.rotation.z = q.z();
    transform.transform.rotation.w = q.w();
    tf_broadcaster.sendTransform(transform);
    this->static_broadcaster.sendTransform(tf::StampedTransform(tf::Transform(tf::Quaternion(0, 0, 0, 1), tf::Vector3(0, 0, 1.2)), ros::Time::now(), "agent_base", "agent_sensor"));
    
    nav_msgs::Odometry odom;
    odom.header.frame_id = "map";
    odom.child_frame_id = "agent_base";
    odom.header.stamp = ros::Time::now();
    odom.pose.pose.position.x = w_pos.x / 10;
    odom.pose.pose.position.y = w_pos.y / 10;
    odom.pose.pose.position.z = 0;
    odom.pose.pose.orientation.x = q.x();
    odom.pose.pose.orientation.y = q.y();
    odom.pose.pose.orientation.z = q.z();
    odom.pose.pose.orientation.w = q.w();
    currentOdom.publish(odom);
    
    msgCommand.header.stamp = ros::Time::now();
    this->explore::failSafe.publish(msgCommand);
}

// This function handles the callback for the particle messages.
// It processes the received particles, identifies the top-weighted particle,
// synchronizes the ZED camera's odometry with the top particle's pose,
// calculates the reward for the top particle, and sets a goal for the robot.
void explore::particlesCallback(sem_cloud::particle_msg msg)
{
    static sem_cloud::particle_struct part_struct;
    static int i = 1;
    float reward = 0;
    int index = 0;
    e = rand();
    
    sem_cloud::particle_struct top_weighted_particle;
    if (ros::Time::now().toSec() - explore::previousTime > 5 )
    {   
        explore::previousTime = ros::Time::now().toSec();

        Eigen::MatrixXf v(3, 1);
        Eigen::MatrixXf particle_current(3, 1);
        i = 1;
        float max_weight = 0;
        
        // Find the particle with the highest weight
        for (int j = 0; j < msg.data.size(); j++)
        {
            if(msg.data[j].w > max_weight)
            {
                top_weighted_particle = msg.data[j];
                max_weight = msg.data[j].w;
            }
        }

        // Synchronize ZED odometry with the top-weighted particle
        sem_cloud::particle_struct w_pos = explore::syncCallback_ZED(explore::odometry_msg, explore::localCloud_, top_weighted_particle);
        std::cout << "Weight of the particle " << w_pos.w << " Position x " << w_pos.x << " Position y " << w_pos.y << "\n";

        i = 0;
        pcl::PointCloud<pcl::PointXYZRGBL>::Ptr currentCloud = explore::transformCloud(explore::nCloud, explore::poseToTransform(top_weighted_particle));

        // Calculate the reward for the top-weighted particle
        vector<float> temp = explore::rewardFunction(currentCloud, w_pos);
        float reward_temp = 0.20 * 30 * temp[0] + 0.40 * (top_weighted_particle.perc) + 0.40 * 100 * (top_weighted_particle.w);
        reward = reward_temp;
        index = int(temp[1]);

        if(true)
        {
            explore::particle.x = top_weighted_particle.x;
            explore::particle.y = top_weighted_particle.y;
            explore::particle.h = top_weighted_particle.h;
            
            part_struct = w_pos;

            tf::Quaternion q;
            q.setRPY(0, 0, part_struct.h * 3.14159 / 180);
            geometry_msgs::TransformStamped transform;
            transform.header.frame_id = "map";
            transform.child_frame_id = "agent_base";
            transform.header.stamp = ros::Time::now();
            transform.transform.translation.x = part_struct.x / 10;
            transform.transform.translation.y = part_struct.y / 10;
            transform.transform.translation.z = 0;
            transform.transform.rotation.x = q.x();
            transform.transform.rotation.y = q.y();
            transform.transform.rotation.z = q.z();
            transform.transform.rotation.w = q.w();
            tf_broadcaster.sendTransform(transform);
            this->static_broadcaster.sendTransform(tf::StampedTransform(tf::Transform(tf::Quaternion(0, 0, 0, 1), tf::Vector3(0, 0, 1.2)), ros::Time::now(), "agent_base", "agent_sensor"));
            
            nav_msgs::Odometry odom;
            odom.header.frame_id = "map";
            odom.child_frame_id = "agent_base";
            odom.header.stamp = ros::Time::now();
            odom.pose.pose.position.x = part_struct.x / 10;
            odom.pose.pose.position.y = part_struct.y / 10;
            odom.pose.pose.position.z = 0;
            odom.pose.pose.orientation.x = q.x();
            odom.pose.pose.orientation.y = q.y();
            odom.pose.pose.orientation.z = q.z();
            odom.pose.pose.orientation.w = q.w();
            currentOdom.publish(odom);

            if(index == 0)
            {
                index = rand() % explore::goal_locations.size();
                std::cout << "Setting random goal \n";
            }
            this->goal_.target_pose.header.stamp = ros::Time::now();
            this->goal_.target_pose.pose.position.x = (explore::goal_locations[index][0]) / 10;
            this->goal_.target_pose.pose.position.y = (explore::goal_locations[index][1]) / 10;
            
            ROS_INFO("Setting goal locations as X: %f, Y: %f", explore::goal_locations[index][0], explore::goal_locations[index][1]);
            this->explorePosition.sendGoal(this->goal_);
            msgCommand.header.stamp = ros::Time::now();
            this->explore::failSafe.publish(msgCommand);
        }
    }
}
// This function calculates the reward for a given particle based on its position and the current point cloud data.
// It transforms the particle's position based on its heading, calculates the distance to each goal location,
// and finds the goal location with the maximum reward that meets certain criteria.
vector<float> explore::rewardFunction(pcl::PointCloud<pcl::PointXYZRGBL>::Ptr currentCloud, sem_cloud::particle_struct position)
{
    float x = position.x;
    float y = position.y;
    float h = position.h * 3.14 / 180;

    Eigen::Matrix2f transformation;
    float eps = 0.1;
    if (e >= eps) // goal only ahead of agent
    {
        transformation << cos(h), -sin(h),
                          sin(h), cos(h);
    }
    else // goal not necessarily ahead of agent
    {
        transformation << 1, 0,
                          0, 1;
    }

    Eigen::MatrixXf positionx(2, 1);
    Eigen::MatrixXf transformedPosition(2, 1);
    positionx << x, y;

    transformedPosition = transformation * positionx;

    float distance = 0;
    float maxReward = 0;
    int maxRewardIndex = 0;

    // Iterate through all goal locations to find the one with the maximum reward
    for (int i = 0; i < (explore::goal_locations.size()); i++)
    {
        float distanceWall = 1000;
        distance = std::pow(std::pow((x - goal_locations[i][0]), 2) + std::pow((y - goal_locations[i][1]), 2), 0.5); // finding the distance between agent and goal

        // finding distance between goal and nearest wall
        for (auto &point : currentCloud->points)
        {
            float distanceL = std::pow(std::pow((point.x - goal_locations[i][0]), 2) + std::pow((point.y - goal_locations[i][1]), 2), 0.5);

            if (distanceL < distanceWall)
            {
                distanceWall = distanceL;
            }
        }

        // Check if the goal location meets the criteria
        if (distance < 60 && distance > 30 && distanceWall > 10)
        {
            Eigen::Matrix2f tempGoal;
            Eigen::Matrix2f goal;

            goal << explore::goal_locations[i][0], explore::goal_locations[i][1];
            tempGoal = transformation * goal;

            // Update the maximum reward and index if the current goal has a higher reward
            if (explore::goal_locations[i][2] > maxReward)
            {
                if (e >= eps) // goal only ahead of agent
                {
                    if (tempGoal(0, 0) > transformedPosition(0, 0))
                    {
                        maxRewardIndex = i;
                        maxReward = explore::goal_locations[i][2];
                    }
                }
                else
                {
                    maxRewardIndex = i;
                    maxReward = explore::goal_locations[i][2];
                }
            }
        }
    }

    vector<float> max = {maxReward, float(maxRewardIndex * 1.0)};
    return max;
}

// This function reads data from a file and stores it in a 2D vector.
// Each line in the file represents a row in the 2D vector, and each word in the line represents an element in the row.
void explore::read_data(string loc, vector<vector<float>> &m)
{
    ifstream is(loc);
    string line;
    float word;
    while (getline(is, line, '\n'))
    {
        vector<float> tempVec;
        istringstream ss(line);
        while (ss >> word)
        {
            tempVec.push_back(word);
        }
        m.emplace_back(tempVec);
    }
}

// Main function to initialize the ROS node and start the exploration process.
// It creates an instance of the explore class and starts the ROS event loop.
int main(int argc, char **argv)
{
    ros::init(argc, argv, "exploreNode");
    ros::NodeHandle nh;
    explore *localize = new explore(nh);
    ros::spin();
    return 0;
}
