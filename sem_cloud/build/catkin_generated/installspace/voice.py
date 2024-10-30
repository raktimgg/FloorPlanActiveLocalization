#!/usr/bin/env python3
import rospy
import sys
from std_msgs.msg import String
#from gtts import gTTS
import os
import pyttsx3


class Commands:
   def __init__(self):
    rospy.init_node('listener', anonymous=True)
    rospy.Subscriber("/commands", String, self.callback, queue_size=1)
    
    # initialisation
    self.engine = pyttsx3.init()
    self.language = 'en'
    #self.engine.setProperty('rate', 300)
    self.pub = rospy.Publisher('commandsHeard', String, queue_size=10)   
   
   def callback(self,data):
    rospy.loginfo(data.data) 
    # testing
    self.engine.say(data.data)
    self.engine.runAndWait()
    self.pub.publish(data)
    

def main(args):
  voice=Commands()
  try:
    rospy.spin()
  except KeyboardInterrupt:
    print("Shutting down")

if __name__ == '__main__':
    main(sys.argv)
