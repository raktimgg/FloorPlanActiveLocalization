#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt
import message_filters
from localization.msg import landmark_msg, particle_msg, robot_struct
import rospy


i = 0

def show_robot(robot, color = 'red'):

    # turtle.shape('tri')
    # turtle.resizemode("user")
    # turtle.shapesize(3, 3, 3)

    # turtle.setposition((robot.x, robot.y))
    # turtle.setheading(robot.heading)
    # turtle.color('red')
    # # turtle.stamp()

    # turtle.update()

    hd = robot.h*np.pi/180
    x1 = robot.x
    y1 = robot.y
    dx = np.cos(hd)*4
    dy = np.sin(hd)*4
    plt.arrow(x1,y1,dx,dy,color = color,width = 2,head_width=4)


def show_doors(doors, robot, show_frequency = 1):

    # turtle.shape('circle')
    # turtle.resizemode("user")
    # turtle.shapesize(0.2, 0.2, 1)
    thr = robot.o_h*np.pi/180
    xr = robot.o_x
    yr = robot.o_y
    H = np.array([[np.cos(thr), -np.sin(thr), xr],
                  [np.sin(thr), np.cos(thr), yr],
                  [0,0,1]])
    doors_data = doors.data
    for i, door in enumerate(doors_data):
        door1 = [door.x,door.y,1]
        door = np.array(door1)
        door = H@door
        door = door[:2]
        if i % show_frequency == 0:
            # turtle.setposition((door[0]+robot.origin_x, door[1]+robot.origin_y))
            # turtle.setposition((door[0], door[1]))
            # turtle.setheading(0)
            # turtle.color('green')
            # turtle.stamp()
            plt.scatter(door[0],door[1],color='red',marker = '.', s= 0.5)

def show_walls(doors, robot, show_frequency = 1):

    # turtle.shape('circle')
    # turtle.resizemode("user")
    # turtle.shapesize(0.2, 0.2, 1)
    thr = robot.o_h*np.pi/180
    xr = robot.o_x
    yr = robot.o_y
    H = np.array([[np.cos(thr), -np.sin(thr), xr],
                  [np.sin(thr), np.cos(thr), yr],
                  [0,0,1]])
    doors_data = doors.data
    for i, door in enumerate(doors_data):
        door1 = [door.x,door.y,1]
        door = np.array(door1)
        door = H@door
        door = door[:2]
        if i % show_frequency == 0:
            # turtle.setposition((door[0]+robot.origin_x, door[1]+robot.origin_y))
            # turtle.setposition((door[0], door[1]))
            # turtle.setheading(0)
            # turtle.color('green')
            # turtle.stamp()
            plt.scatter(door[0],door[1],color='green',marker = '.', s= 0.5)

def show_robot_origin(robot, show_frequency = 1):

    # turtle.shape('tri')
    # turtle.resizemode("user")
    # turtle.shapesize(3, 3, 3)

    # turtle.setposition((robot.origin_x, robot.origin_y))
    # turtle.setheading(robot.origin_heading)
    # turtle.color('green')
    # turtle.stamp()

    # turtle.update()

    hd = robot.o_h*np.pi/180
    x1 = robot.o_x
    y1 = robot.o_y
    dx = np.cos(hd)*4
    dy = np.sin(hd)*4
    plt.arrow(x1,y1,dx,dy,color = 'green',width = 2,head_width=4)


def show_particles(particles):
	w = 0
	ind = 0
	for i in range(len(particles.data)):
		particle = particles.data[i]
		if(i!=0):
			hd = particle.h*np.pi/180
			x1 = particle.x
			y1 = particle.y
			w1 = particle.w
			dx = np.cos(hd)*1
			dy = np.sin(hd)*1
			plt.arrow(x1,y1,dx,dy,color = 'black',width = 0.2,head_width=0.4)
		else:
			hd = particle.h*np.pi/180
			x1 = particle.x
			y1 = particle.y
			w1 = particle.w
			dx = np.cos(hd)*4
			dy = np.sin(hd)*4
			plt.arrow(x1,y1,dx,dy,color = 'blue',width = 2,head_width=4)


def plot_fn(doors, walls, particles, robot):
	global i
	plt.figure(figsize=(10,10))
	plt.ylim(0,500)
	plt.xlim(0,300)
	# print(threading.current_thread().name)
	# self.world.show_maze()
	# self.world.show_walls(self.landmarks_walls,self.robot)
	show_doors(doors, robot)
	show_walls(walls, robot)
	show_robot_origin(robot)
	show_particles(particles)
	# self.world.show_top_particle(self.top_particle)
	show_robot(robot)
	plt.savefig('/home/crrl/crrl_ws2/src/localization/src/python/Figs/'+str(i)+'.png')
	i += 1
	# plt.pause(1)
	plt.close()



rospy.init_node('plotting')

doors = message_filters.Subscriber("/landmarks_doors",landmark_msg,queue_size = 1)
walls = message_filters.Subscriber("/landmarks_walls",landmark_msg,queue_size = 1)
particles = message_filters.Subscriber("/particles",particle_msg,queue_size = 1)
robot = message_filters.Subscriber("/robot",robot_struct,queue_size = 1)

ts = message_filters.TimeSynchronizer([doors,walls,particles,robot],10)
ts.registerCallback(plot_fn)

rospy.spin()
