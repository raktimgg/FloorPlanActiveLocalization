import numpy as np
from localization.msg import particle_msg, particle_struct
import rospy
import scipy.cluster.hierarchy as hcluster
from std_msgs.msg import Float64

# Global variables to keep track of the count and previous best particle coordinates
global count
count = 0
global p1x
global p1y
p1x = 0
p1y = 0

# Function to calculate the Euclidean distance between two points
def dist(p1, p2):
    return np.sqrt((p1[0]/10 - p2[0]/10)**2 + (p1[1]/10 - p2[1]/10)**2)

# Function to process the incoming particles and send messages
def send_message(particles):
    global count
    global p1, p1x, p1y

    # Return if no particles are received
    if len(particles.data) == 0:
        return

    # Convert particle data to a numpy array
    data = np.zeros([len(particles.data), 4])
    for i in range(len(particles.data)):
        data[i, 0] = particles.data[i].x
        data[i, 1] = particles.data[i].y
        data[i, 2] = particles.data[i].h
        data[i, 3] = particles.data[i].w

    # Clustering particles based on their x and y coordinates
    thresh = 20
    clusters = hcluster.fclusterdata(data[:, :2], thresh, criterion="distance")

    # Find the best cluster with the maximum number of particles
    best_cluster = np.bincount(clusters).argmax()
    best_indices = np.where(clusters == best_cluster)[0]
    best_particles = data[best_indices]
    ind = np.argmax(best_particles[:, 3])

    # Get the best particle in the best cluster
    x, y, h, w = best_particles[ind, 0], best_particles[ind, 1], best_particles[ind, 2], best_particles[ind, 3]
    p1 = [p1x, p1y]
    p2 = [x, y]
    percentage = best_indices.shape[0] / len(particles.data) * 100

    # Print information about the best cluster
    print("Percentage:", percentage, "%, Number of clusters:", len(set(clusters)), 'count', count)
    print("Best cluster:", x, y, h)
    print("Best cluster weight: ", w)
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

    # Create a message with the centroids of all clusters
    centroids = particle_msg()
    for i in set(clusters):
        cluster_indices = np.where(clusters == i)[0]
        cluster_particles = data[cluster_indices]
        ind = np.argmax(cluster_particles[:, 3])
        temp = particle_struct()
        temp.x, temp.y, temp.h, temp.w = cluster_particles[ind, 0], cluster_particles[ind, 1], cluster_particles[ind, 2], cluster_particles[ind, 3]
        temp.perc = cluster_indices.shape[0] / len(particles.data) * 100
        centroids.data.append(temp)

    # Publish the centroids of the clusters
    pub_particle.publish(centroids)

    # Check if the localization is successful
    if len(set(clusters)) <= 2 and percentage > 90:
        if dist(p1, p2) <= 5:
            count += 1
        else:
            p1x = x
            p1y = y
            count = 0
    else:
        count = 0

    # If the count reaches 50, publish success and shutdown the node
    if count >= 50:
        pub.publish(1)
        rospy.signal_shutdown('Localized successfully!!')
    else:
        pub.publish(0)

# Initialize the ROS node
rospy.init_node('Notification_node', disable_signals=True)

# Subscribe to the particles topic
rospy.Subscriber("/particles", particle_msg, send_message)

# Publishers for localization percentage and clustered particles
pub = rospy.Publisher('loc_percentage', Float64, queue_size=10)
pub_particle = rospy.Publisher('clustered_particles', particle_msg, queue_size=10)

# Keep the node running
rospy.spin()
