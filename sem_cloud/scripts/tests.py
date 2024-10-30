#!/usr/bin/env python3
import subprocess
import rospy
import pandas as pd
# from sem_cloud.msg import topParticle
from localization.msg import topParticle
from std_msgs.msg import Int32
import roslaunch
import time

class test:
    def __init__(self,path):
        rospy.init_node("testLog")
        self.dataList = pd.DataFrame(columns=['X','Y','Z','Xg','Yg','Zg','time','door landmarks','wall landmarks'])
        self.particle = rospy.Subscriber("/top_particle",topParticle,self.particleCallback)
        self.pub = rospy.Publisher('/count',Int32,queue_size = 10)
        self.testData = pd.read_csv('/home/crrl/crrl_ws/src/sem_cloud/testdata/TestData2ndFloor.csv') 
        self.count    = 0
        self.currentX = 0
        self.CurrentY = 0
        self.x = 0
        self.y = 0
        self.time = []
        self.doors = 0
        self.walls = 0
        self.dist = 0


    def distance(self,currentX,currentY,x,y):
        return ((currentX-x)**2+(currentY-y)**2)**(0.5)

    def particleCallback(self,mes):
        self.x = mes.x
        self.y = mes.y
        self.time.append(mes.time)
        self.walls = mes.walls
        self.doors = mes.doors
        self.dist = self.distance(self.currentX,self.currentY,self.x,self.y)
        if(self.dist<50):
            self.count+=1
        else:
            self.count=0	
        self.pub.publish(int(self.dist)) 

    def testing(self):
        for index,row in self.testData.iterrows():
            ref_time = time.time() 
            self.count = 0
            self.currentX = row['x']
            self.currentY = row['y']
            cli_args = ['/home/crrl/crrl_ws/src/sem_cloud/launch/bag.launch','time:='+str(row['time'])]
            uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
            roslaunch_args = cli_args[1:]
            roslaunch_file = [(roslaunch.rlutil.resolve_launch_arguments(cli_args)[0], roslaunch_args)]
            parent = roslaunch.parent.ROSLaunchParent(uuid, roslaunch_file)
            parent.start()	
            while(self.count<=2):
                self.pub.publish(self.count) 
                if len(self.time)>0 and self.time[-1]>100:
                    killProcess = subprocess.Popen(["killall", "-9", "roscore"])
                    break
                pass  
            if(self.count>=2):
                # process.kill() 
                killProcess = subprocess.Popen(["killall", "-9", "roscore"])
            print("Time over")
            parent.shutdown()
               # killProcess = subprocess.Popen(["killall", "-9", "roscore"])		
            # self.dataList = self.dataList.append({"X":self.x,"Y":self.y,"Xg":self.currentX,"Yg":self.currentY,"time":self.time[-3],"door landmarks":self.doors,"wall landmarks":self.walls}, ignore_index=True)
            self.dataList = pd.concat([self.dataList, pd.DataFrame([{"X":self.x,"Y":self.y,"Xg":self.currentX,"Yg":self.currentY,"time":self.time[-3],"door landmarks":self.doors,"wall landmarks":self.walls}])])
            self.dataList.to_csv("testResult.csv",index=False)
                #killProcess.kill()
            print("Done with testing ",index)
            self.time = []
            if(index>120):
                break
        self.dataList.to_csv("testData.csv",index=False)

if __name__=='__main__':
   try:      
      t = test('testData')
      t.testing()
   except rospy.ROSInterruptException:
      pass

    





