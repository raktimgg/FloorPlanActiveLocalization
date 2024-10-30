#!/usr/bin/env python

import rospy
from sem_cloud.msg import topParticle  
import csv

class MessageLogger:
    def __init__(self):
        self.messages = []
        self.subscriber = rospy.Subscriber('sem_cloud/topParticle', topParticle, self.message_callback)

    def message_callback(self, msg):
        self.messages.append(msg)

    def save_to_csv(self, filename):
        if len(self.messages) == 0:
            rospy.loginfo("No messages to save.")
            return

        fields = ["x", "y", "h", "time"]  # Fields from the TopParticle message
        with open(filename, mode='w') as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=fields)
            writer.writeheader()

            for msg in self.messages:
                writer.writerow({"x": msg.x, "y": msg.y, "h": msg.h, "time": msg.time})

if __name__ == '__main__':
    rospy.init_node('message_logger_node', anonymous=True)
    logger = MessageLogger()

    try:
        rospy.spin()
    except KeyboardInterrupt:
        rospy.loginfo("Shutting down message logger node...")
        logger.save_to_csv('message_log.csv')
