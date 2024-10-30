;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::EnvSensor)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'EnvSensor (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::ENVSENSOR")
  (make-package "SEM_CLOUD::ENVSENSOR"))

(in-package "ROS")
;;//! \htmlinclude EnvSensor.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass sem_cloud::EnvSensor
  :super ros::object
  :slots (_header _type _value ))

(defmethod sem_cloud::EnvSensor
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) 0)
    ((:value __value) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _type (round __type))
   (setq _value (float __value))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _type
    4
    ;; float64 _value
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _type
       (write-long _type s)
     ;; float64 _value
       (sys::poke _value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _value
     (setq _value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get sem_cloud::EnvSensor :md5sum-) "9df4dc52b9b74f3a81eaae9eecf9c0e0")
(setf (get sem_cloud::EnvSensor :datatype-) "sem_cloud/EnvSensor")
(setf (get sem_cloud::EnvSensor :definition-)
      "
Header header

# EnvSensor
int32 type
float64 value
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :sem_cloud/EnvSensor "9df4dc52b9b74f3a81eaae9eecf9c0e0")


