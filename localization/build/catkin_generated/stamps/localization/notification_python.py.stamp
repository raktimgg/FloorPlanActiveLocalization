import numpy as np
from localization.msg import particle_msg, particle_struct
import rospy
import scipy.cluster.hierarchy as hcluster
from std_msgs.msg import Float64

import actionlib
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal


def movebase_client():

    client = actionlib.SimpleActionClient('move_base',MoveBaseAction)
    client.wait_for_server()

    goal = MoveBaseGoal()
    goal.target_pose.header.frame_id = "map"
    goal.target_pose.header.stamp = rospy.Time.now()
    goal.target_pose.pose.position.x = 25
    goal.target_pose.pose.position.y = 25
    # goal.target_pose.pose.orientation.w = 25

    client.send_goal(goal)
    wait = client.wait_for_result()
    if not wait:
        rospy.logerr("Action server not available!")
        rospy.signal_shutdown("Action server not available!")
    else:
        return client.get_result()


global count
count = 0

global msg_count
msg_count = 0

global last_best_particle
last_best_particle = None
def send_message(particles):
    global count
    global msg_count
    global last_best_particle
    if len(particles.data)==0:
        return
    data = np.zeros([len(particles.data),4])
    for i in range(len(particles.data)):
        data[i,0] = particles.data[i].x
        data[i,1] = particles.data[i].y
        data[i,2] = particles.data[i].h
        data[i,3] = particles.data[i].w
    thresh = 25
    clusters = hcluster.fclusterdata(data[:,:2], thresh, criterion="distance")
    
    best_cluster = np.bincount(clusters).argmax()
    best_indices = np.where(clusters==best_cluster)[0]
    best_particles = data[best_indices]
    ind = np.argmax(best_particles[:,3])

    x,y,h,w = best_particles[ind,0],best_particles[ind,1],best_particles[ind,2],best_particles[ind,3]
    percentage = best_indices.shape[0]/len(particles.data)*100

    if count==0:
        last_best_particle = best_particles[ind]
        count = count + 1
    else:
        new_best_particle = best_particles[ind]
        if np.sqrt( (last_best_particle[0]/10-new_best_particle[0]/10)**2 + (last_best_particle[1]/10-new_best_particle[1]/10)**2 ) < 3:
            count = count + 1
        else:
            count = 0
    
    if count>=4 and percentage>60:
        print('Successfully localized with', percentage, '% probability at ', x,',', y,',', h,',')
        msg_count += 1
        # result = movebase_client()
        pub.publish(1)

        rospy.signal_shutdown('Done')

    pub.publish(0)

    # percentage = best_indices.shape[0]/len(particles.data)*100
    # pub.publish(percentage)
    print("Percentage:", percentage, "%, Number of clusters:", len(set(clusters)))
    print("Best particle:",x,y,h)
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    centroids = particle_msg()
    for i in set(clusters):
        cluster_indices = np.where(clusters==i)[0]
        cluster_particles = data[cluster_indices]
        ind = np.argmax(cluster_particles[:,3])
        temp = particle_struct()
        temp.x,temp.y,temp.h,temp.w = cluster_particles[ind,0],cluster_particles[ind,1],cluster_particles[ind,2],cluster_particles[ind,3]
        temp.perc = cluster_indices.shape[0]/len(particles.data)*100
        centroids.data.append(temp)
    pub_particle.publish(centroids)



rospy.init_node('Notification_node', disable_signals=True)
rospy.Subscriber("/particles",particle_msg,send_message)
pub = rospy.Publisher('perc_notification', Float64,queue_size=10)
pub_particle = rospy.Publisher('clustered_particles', particle_msg,queue_size=10)



rospy.spin()
