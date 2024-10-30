#include<iostream>
#include<fstream>
#include<list>
#include<vector>
#include<sstream>
#include<string>
#include<math.h>
#include<iterator>
#include<random>
#include<cstdlib>
#include<cmath>
#include<algorithm>
#include<numeric>

#include"maze.cpp"
#include"ros/ros.h"
#include<message_filters/subscriber.h>
#include<message_filters/time_synchronizer.h>
#include<sensor_msgs/PointCloud2.h>
#include<std_msgs/Float64MultiArray.h>
#include<rtabmap_ros/MapGraph.h>
#include<pcl_ros/point_cloud.h>
#include<pcl/PCLPointCloud2.h>
#include<sensor_msgs/PointCloud.h>
#include<pcl/point_types.h>
#include<boost/foreach.hpp>
#include<sensor_msgs/point_cloud_conversion.h>
#include<sensor_msgs/point_cloud2_iterator.h>
#include<pcl/pcl_config.h>
#include<pcl_conversions/pcl_conversions.h>
#include<localization/topParticle.h>


#include<localization/landmark_msg.h>
#include<localization/coordinate.h>
#include<localization/particle_struct.h>
#include<localization/particle_msg.h>
#include<localization/robot_struct.h>
#include<localization/robot_msg.h>


using namespace std;
using namespace sensor_msgs;
using namespace message_filters;
using namespace std_msgs;
using namespace rtabmap_ros;
using namespace pcl;

/*
IMPORTANT:
1. Check if the angle ranges are causing issues in update pos and local_pos
2. Check multiplication functions

*/

class ParticleFilter
{
	public:
		int sensor_limit = 70;
		int num_cols;
		int particle_divide = 5;
		int t = 0;
		// int i = 0;
		// int j = 0;
		int top_particle[3] = {-1,-1,1000};
		int num_particles = 5000;
		float eps = 0.1;
		float M = 10;
		float wall_ratio = 0.4;
		
		vector<vector<float>> doors;
		vector<vector<float>> walls;
		vector<vector<float>> permissible_space;

		Robot robot;
		vector<Particles> particles;
		vector<Particles> top_n_particles;

		vector<vector<float>> landmarks;
		vector<vector<float>> landmarks_walls;

		ros::Publisher pub;
		ros::Publisher pub_particle;
		ros::Publisher pub_pcl;
		
		Header header;


		// Constructor for initializing robot and particles
		ParticleFilter()
		{
			// Load environment data (doors, walls, permissible space)
			read_data("/home/crrl/crrl_ws/src/localization/src/CPP/doors_walls/doors.txt",doors);
			read_data("/home/crrl/crrl_ws/src/localization/src/CPP/doors_walls/walls.txt",walls);
			read_data("/home/crrl/crrl_ws/src/localization/src/CPP/permissible_space.txt",permissible_space);

			// Initialize the robot's position and orientation
			robot.initialize(8,410,0);
			// Initialize the particles for the particle filter
			initialize_particles(num_particles);
		}

		void localize(int argc, char** argv)
		{
			ros::init(argc, argv, "localization");
			ros::NodeHandle nh;

			message_filters::Subscriber<PointCloud2> pt_cl(nh, "/sync/cloud", 1);
			message_filters::Subscriber<MapGraph> rb_ps(nh, "/rtabmap/mapGraph", 1);

			// Advertise topics for top particle, particles, and 2D point cloud
			pub = nh.advertise<localization::topParticle>("/top_particle", 10);
			pub_particle = nh.advertise<localization::particle_msg>("/particles", 1);
			pub_pcl = nh.advertise<PointCloud2>("/pcl_2d",1);
			
			// Synchronize point cloud and map graph topics and bind callback function
			TimeSynchronizer<PointCloud2, MapGraph> sync(pt_cl, rb_ps, 10);
			sync.registerCallback(boost::bind(&ParticleFilter::add_slam_data,this, _1, _2));
			ros::Rate rate(100); // 10 Hz
			while (ros::ok()) 
			{
				// Perform continuous actions here
				// ROS_INFO("Running continuously...");
				// cout<<landmarks.size()<<"\n";
				if(landmarks.size()==0 && landmarks_walls.size()==0)
				{
					ros::spinOnce();
					continue;
				}
				filtering();

				// Spin once to process any incoming messages (if you still want to receive messages)
				ros::spinOnce();

				// Sleep to maintain the loop rate
				rate.sleep();
			}
//			Float64MultiArray msg;
//			msg.data.push_back(top_particle[0]);
//			msg.data.push_back(top_particle[1]);
//			msg.data.push_back(top_particle[2]);
//			pub.publish(msg);

			ros::spin();
		}

		void add_slam_data(const PointCloud2ConstPtr& data, const MapGraphConstPtr& data_pos)
		{
			header = data->header;
			update_robot_pos(data_pos);
			add_landmarks(data);
		}

		void filtering()
		{
			
			static double begin = ros::Time::now().toSec();	
				
			// update_robot_pos(data_pos);

			// int landmark_size = landmarks.size();
			// int landmark_walls_size = landmarks_walls.size();
			// add_landmarks(data);
			// if(landmark_size != landmarks.size() || landmark_walls_size != landmarks_walls.size())
			// {
			// 	update_particles();
			// 	// print_particle_weight();
			// }
			update_particles();

			if (landmarks.size() >= 150)
				num_particles = 2000;
			if (landmarks.size() >= 400)
				num_particles = 500; 
			t += 1;
				// Log status information (landmarks, particle state, elapsed time)
                        double time_now = ros::Time::now().toSec();	
			cout<<"Num doors pts: "<<landmarks.size()<<" Num wall pts: "<<landmarks_walls.size() <<", Top Part: [ "<<top_particle[0]<<", "
			<<top_particle[1]<<", "<<top_particle[2]<<"]"<< "Time -: "<<time_now-begin <<endl;
				
			// Publish top particle information
			localization::topParticle msg;
			msg.time = time_now-begin;
			msg.x 	 = top_particle[0];
			msg.y  	 = top_particle[1];
			msg.heading  	 = top_particle[2];
			msg.doors = landmarks.size();
			msg.walls = landmarks_walls.size();
			pub.publish(msg);
			
			// header = data->header;
			
			localization::particle_struct temp2;
			localization::particle_msg particle_pub_msg;
			particle_pub_msg.header = header;

			for(int i=0; i<top_n_particles.size();i++)
			{
				temp2.x = top_n_particles[i].x;
				temp2.y = top_n_particles[i].y;
				temp2.h = top_n_particles[i].heading;
				temp2.w = top_n_particles[i].weight;
				particle_pub_msg.data.push_back(temp2);
			}
			
			pub_particle.publish(particle_pub_msg);
			
			// Publish point cloud data for walls
			sensor_msgs::PointCloud2 cloudMsgL;
			pcl::PointCloud<pcl::PointXYZRGBL>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZRGBL>);
			//cloud->height = imageGray.rows/decimation;
    			//cloud->width  = imageGray.cols/decimation;
    			cloud->is_dense = false;
    			cloud->resize(landmarks_walls.size());
			for(int i=0; i<landmarks_walls.size(); i++)
			{
				pcl::PointXYZRGBL & pt = cloud->at(i);
				pt.x = float(landmarks_walls[i][0]);
				pt.y = float(landmarks_walls[i][1]);
				pt.z = 0;
			}
			pcl::toROSMsg(*cloud,cloudMsgL);
			cloudMsgL.header = header;
			pub_pcl.publish(cloudMsgL);

		}

		void print_particle_weight()
		{
			for(int i=0; i<particles.size();i++)
			{
				cout<<"i "<<i<<" "<<particles[i].weight<<"\n";
			}
		}

		void update_particles()
		{
			if(landmarks.size()==0 && landmarks_walls.size()==0)
				return;
			float xr = robot.local_x;
			float yr = robot.local_y;
			float headingr = robot.local_heading*3.14159/180;

			// Homogeneous transformation matrix for robot in particle frame

			float H_r_in_p[3][3] = {{cos(headingr), -sin(headingr), xr},
									{sin(headingr), cos(headingr), yr},
									{0,0,1}};
			float xp, yp, headingp, weight;
			// float H_p_in_w[3][3];
			float H_r_in_w[3][3];
			int i;

			// Loop through each particle to update its weight
			
			for(i=0; i<particles.size();i++)
			{
				xp = particles[i].x;
				yp = particles[i].y;
				headingp = particles[i].heading*3.14159/180;
				
				// Homogeneous transformation matrix for particle in world frame
				float H_p_in_w[3][3] = {{cos(headingp), -sin(headingp), xp},
							{sin(headingp), cos(headingp), yp},
							{0,0,1}};
				
				mat_mul_3x3(H_p_in_w,H_r_in_p,H_r_in_w);
				
				// Calculate particle weight based on this transformation
				weight = find_weight(H_p_in_w);
				particles[i].weight = weight;
			}
			special_resample_particles();

		}

		void special_resample_particles()
		{
			top_n_particles = arange_particles();

			// Set the best particle as the top one
			top_particle[0] = top_n_particles[0].x;
			top_particle[1] = top_n_particles[0].y;
			top_particle[2] = top_n_particles[0].heading;
			
			float x_, y_, h_;
			int k;
			default_random_engine generator;
  			normal_distribution<float> distribution(0.0,10.0);
			particles.clear();	
			for(int i=0; i<top_n_particles.size(); i++)
			{
				k=0;
				while(k<particle_divide-2)
				{
					k += 1;

					// Add noise to top particle's position and heading
					x_ = top_n_particles[i].x + distribution(generator);
					y_ = top_n_particles[i].y + distribution(generator); 
					h_ = top_n_particles[i].heading + distribution(generator);
					
					// Ensure particle is within permissible space
					while(check_permissible_space(x_, y_) != 1)
					{
						x_ = top_n_particles[i].x;
						y_ = top_n_particles[i].y;
					}

					// Initialize new particle and add it to the particle set
					Particles tempPart;
					tempPart.initialize(x_,y_,h_);
					particles.push_back(tempPart);
				}
			}
			int num_extra_part_req = num_particles - particles.size();
			initialize_particles(num_extra_part_req);
		}

		int check_permissible_space(float x_, float y_)     // check this function
		{
			x_ = round(x_);
			y_ = round(y_);

			// Create a temporary vector with rounded coordinates
			vector<float> temp;
			temp.push_back(x_);
			temp.push_back(y_);
			
			// Check if the coordinates are in the permissible space
			if(count(permissible_space.begin(), permissible_space.end(), temp))
			{
				return 1;
			}
			return 0;
		}

		vector<Particles> arange_particles()
		{
			// float a[particles.size()] = {0};
			vector<float> a;
			
			// Populate the vector with the weights of all particles
			for(int i=0; i<particles.size(); i++)
			{
				a.push_back(particles[i].weight);
			}

			// Sort the particle indices based on their weights
			vector<size_t> arg = sort_indexes(a);
			vector<Particles> res;

			// Select top particles based on sorted weights (in descending order)
			for(int i=0; i<int(num_particles/particle_divide); i++)
			{
				res.push_back(particles[arg[arg.size()-i-1]]);   // check if it is increasing or decreasing
			}
			return res;

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
				[&v](size_t i1, size_t i2) {return v[i1] < v[i2];});

			return idx;
		}

		float find_weight(float H[3][3])
		{
			float wi_doors = 0;
			
			// Calculate weight contribution from landmarks (doors)
			for(int i=0; i<landmarks.size(); i++)
			{
				float p1[3] = {landmarks[i][0], landmarks[i][1], 1};
				float points_w[2] = { H[0][0]*p1[0] + H[0][1]*p1[1] + H[0][2]*p1[2],
									  H[1][0]*p1[0] + H[1][1]*p1[1] + H[1][2]*p1[2]};
				
				wi_doors += d(points_w);
			}

			float wi_walls = 0;
			
			// Calculate weight contribution from landmarks_walls
			for(int i=0; i<landmarks_walls.size(); i++)
			{
				float p1[3] = {landmarks_walls[i][0], landmarks_walls[i][1], 1};
				float points_w[2] = { H[0][0]*p1[0] + H[0][1]*p1[1] + H[0][2]*p1[2],
									  H[1][0]*p1[0] + H[1][1]*p1[1] + H[1][2]*p1[2]};
				
				wi_walls += d_walls(points_w);
			}

			// cout<<"wi_d "<<wi_doors<<" wi_w "<<wi_walls<<"\n";
			// float wi = wall_ratio*wi_walls;

			// Combine door and wall weights using the wall ratio
			float wi = (1-wall_ratio)*wi_doors + wall_ratio*wi_walls;
			
			// float wi = wall_ratio*wi_walls;
			// float w_d = 1/wi_doors;
			// float w_w = 1/wi_walls;
			// cout<<"w_d "<<w_d<<" w_w "<<w_w<<"\n";
			// float w = w_d + 0.01*w_w;
			//float wi = (landmarks.size()*1.0/(landmarks.size()+landmarks_walls.size()/10))*wi_doors + ((landmarks_walls.size()*1.0/10)/(landmarks.size()+landmarks_walls.size()/10))*wi_walls;
			//cout << "Weight - "<<wi<<endl;
//			cout << "a - "<<(landmarks.size()*1.0/(landmarks.size()+landmarks_walls.size()/5))<<endl;
//			cout << "b - "<<((landmarks_walls.size()*1.0/5)/(landmarks.size()+landmarks_walls.size()/5))<<endl;
//			cout << "c - "<<landmarks.size()<<endl;
//			cout << "d - "<<landmarks_walls.size()<<endl;
			float w = 1/wi;
			// float w = 1/wi_doors;
			return w;
		}

		float d(float p[2])
		{
			// Calculate the minimum distance to the nearest door
			float x = p[0];
			float y = p[1];
			float x1, x2, y1, y2;
			float dist[doors.size()];
			for(int i=0; i< doors.size(); i++)
			{
				x1 = doors[i][0];
				y1 = doors[i][1];
				x2 = doors[i][2];
				y2 = doors[i][3];
				dist[i] = find_nearest_door(x,y,x1,y1,x2,y2);
			}
			return find_min(dist, doors.size());
		}


		float d_walls(float p[2])
		{
			// Calculate the minimum distance to the nearest wall
			float x = p[0];
			float y = p[1];
			float x1, x2, y1, y2;
			float dist[walls.size()];
			for(int i=0; i< walls.size(); i++)
			{
				x1 = walls[i][0];
				y1 = walls[i][1];
				x2 = walls[i][2];
				y2 = walls[i][3];
				dist[i] = find_nearest_door(x,y,x1,y1,x2,y2);
			}
			return find_min(dist, walls.size());
		}

		float f(float d)
		{

			// Function to handle distance values
			if(d<=eps)
				return eps;
			if(d<M)
				return d-eps;
			return M-eps;
		}


		float find_min(float arr[], int N)
		{
			// Find and return the minimum value in an array
			float min = INT_MAX, max = INT_MIN;
			for (int i=0; i<N; i++)
			{
				if (arr[i] < min) {
					min = arr[i];
				}
			}
			return min;
		}

		float find_nearest_door(float x, float y,float x1, float y1,float x2, float y2)
		{
			
			// Calculate the nearest point on the line segment (x1, y1) to (x2, y2)
			// and return the distance from (x, y) to that point
			float A = x - x1;
			float B = y - y1;
			float C = x2 - x1;
			float D = y2 - y1;

			float dot = A * C + B * D;
			float len_sq = C * C + D * D;
			float param = -1;
			float xx;
			float yy;

			if (len_sq != 0)
				param = dot/len_sq;

			if (param < 0)
			{
				xx = x1;
				yy = y1;
			}
			else
			if(param > 1)
			{
				xx = x2;
				yy = y2;
			}
			else
			{
				xx = x1 + param * C;
				yy = y1 + param * D;
			}
				

			float dx = x - xx;
			float dy = y - yy;
			return sqrt(dx * dx + dy * dy);
		}

		void mat_mul_3x3(float A[3][3],float B[3][3], float product[3][3])
		{
			int i, j, k;
			int r1 = 3;
			int c1 = 3;
			int r2 = 3;
			int c2 = 3;
			// float product[r1][c2];
			for(i=0; i<r1; ++i)
			{
				for(j=0; j<c2; ++j) 
				{
					product[i][j] = 0;
				}
			}
				
			for(i=0; i<r1; ++i)
			{
				for(j=0; j<c2; ++j)
				{
					for(k=0; k<c1; ++k) 
					{
						product[i][j]+=A[i][k]*B[k][j];
					}
				}
			}
      	}

		void add_landmarks(const PointCloud2ConstPtr& data)
		{
			// Convert point cloud data to usable format
			pcl::PointCloud<pcl::PointXYZRGBL>::Ptr nCloud(new pcl::PointCloud<pcl::PointXYZRGBL>);
			pcl::fromROSMsg(*data, *nCloud);
			landmarks.clear();
			landmarks_walls.clear();

			// Loop through point cloud and classify points as landmarks or wall points
			for (pcl::PointCloud<pcl::PointXYZRGBL>::iterator it = nCloud->begin(); it != nCloud->end(); ++it)
			{
				if(it->label==14&& it->z >=-0.2 && it-> z<= 0.9)
				{
					vector<float> temp;
					temp.push_back(round(it->x*10));
					temp.push_back(round(it->y*10));
					landmarks.push_back(temp);
				}
				else
				if(it->label==0 && it->z >=-0.2 && it-> z<= 0.9)
				{
					vector<float> temp;
					temp.push_back(round(it->x*10));
					temp.push_back(round(it->y*10));
					landmarks_walls.push_back(temp);
				}
				
				// int n = landmarks.size();
				// cout<<landmarks[n-1][0]<<" "<<landmarks[n-1][1]<<"\n";
			}
			remove_redundancies_from_landmarks();
		}

		void remove_redundancies_from_landmarks()
		{
			sort( landmarks.begin(), landmarks.end() );
			landmarks.erase( unique( landmarks.begin(), landmarks.end() ), landmarks.end() );

			sort( landmarks_walls.begin(), landmarks_walls.end() );
			landmarks_walls.erase( unique( landmarks_walls.begin(), landmarks_walls.end() ), landmarks_walls.end() );
		}

		void update_robot_pos(const MapGraphConstPtr& data)
		{
			// Update the robot's position and heading from SLAM data
			float trans_x, trans_y, trans_z, quat_x, quat_y, quat_z, quat_w;
			int sz = data->poses.size();
			trans_x = data->poses[sz-1].position.x;
			trans_y = data->poses[sz-1].position.y;
			trans_z = data->poses[sz-1].position.z;

			quat_x = data->poses[sz-1].orientation.x;
			quat_y = data->poses[sz-1].orientation.y;
			quat_z = data->poses[sz-1].orientation.z;
			quat_w = data->poses[sz-1].orientation.w;

			float yaw = get_yaw(quat_x, quat_y, quat_z, quat_w);

			// Update robot's position and heading in local coordinates
			robot.local_x = trans_x*10;
			robot.local_y = trans_y*10;
			robot.local_heading = yaw;
			robot.local_pos();
		}

		float get_yaw(float q3, float q2, float q1, float q0)
		{
			// Calculate yaw (rotation around the Z-axis) from quaternion
			float yaw;
			yaw = atan2(2*(q0*q1 + q2*q3), 1 - 2*(q1*q1 + q2*q2))*180/3.14159;

			return yaw;
		}

		void initialize_particles(int num_p)
		{
			// Initialize particles with random positions in permissible space
			int num_part, ind;
			if(num_p!=0)
				num_part = num_p;
			else
				num_part = num_particles;
			float x_, y_, heading_;

			for(int i =0; i<num_part; i++)
			{
				// Select random position from permissible space
				ind = rand()%permissible_space.size();
				x_ = permissible_space[ind][0];
				y_ = permissible_space[ind][1];
				heading_ = rand()%360;
				
				// Initialize a particle with the selected position and heading
				Particles tempPart;
				tempPart.initialize(x_,y_,heading_);
				particles.push_back(tempPart);
			}
			normalize_paricle_weights();
		}

		void normalize_paricle_weights()
		{

			// Normalize particle weights so their sum is 1
			float tl_weight = 0;
			for(int i =0; i<particles.size(); i++)
			{
				tl_weight += particles[i].weight;

			}
			for(int i =0; i<particles.size(); i++)
			{
				particles[i].weight = particles[i].weight/tl_weight;

			}
		}

		void read_data(string loc, vector<vector<float>>& m)
		{
			// Read data from a file and store it in a 2D vector
			ifstream is(loc);
			string line;
			float word;
			while(getline(is,line,'\n'))
			{
				vector<float> tempVec;
				istringstream ss(line);
				while(ss>>word)
				{
					tempVec.push_back(word);
				}
				m.emplace_back(tempVec);

			}
		}

		void print_data( vector <vector<float> >& m)
		{
			// Print 2D vector data
		    for (int i = 0; i<m.size(); i++)
		    {
		        for (int j = 0; j < m[i].size(); j++)
		        {
		            cout << m[i][j] << " ";
		        }
		        cout << "\n";
		    }
		}

		

};




int main(int argc, char** argv)
{
	// Seed random number generator
	srand((unsigned) time(NULL));

	// Create and localize the particle filter
	ParticleFilter pf;
	pf.localize(argc, argv);

	return 0;
}
