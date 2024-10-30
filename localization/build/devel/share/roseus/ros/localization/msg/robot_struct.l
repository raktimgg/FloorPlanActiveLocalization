;; Auto-generated. Do not edit!


(when (boundp 'localization::robot_struct)
  (if (not (find-package "LOCALIZATION"))
    (make-package "LOCALIZATION"))
  (shadow 'robot_struct (find-package "LOCALIZATION")))
(unless (find-package "LOCALIZATION::ROBOT_STRUCT")
  (make-package "LOCALIZATION::ROBOT_STRUCT"))

(in-package "ROS")
;;//! \htmlinclude robot_struct.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass localization::robot_struct
  :super ros::object
  :slots (_header _x _y _h _o_x _o_y _o_h _l_x _l_y _l_h ))

(defmethod localization::robot_struct
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:h __h) 0.0)
    ((:o_x __o_x) 0.0)
    ((:o_y __o_y) 0.0)
    ((:o_h __o_h) 0.0)
    ((:l_x __l_x) 0.0)
    ((:l_y __l_y) 0.0)
    ((:l_h __l_h) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _h (float __h))
   (setq _o_x (float __o_x))
   (setq _o_y (float __o_y))
   (setq _o_h (float __o_h))
   (setq _l_x (float __l_x))
   (setq _l_y (float __l_y))
   (setq _l_h (float __l_h))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:h
   (&optional __h)
   (if __h (setq _h __h)) _h)
  (:o_x
   (&optional __o_x)
   (if __o_x (setq _o_x __o_x)) _o_x)
  (:o_y
   (&optional __o_y)
   (if __o_y (setq _o_y __o_y)) _o_y)
  (:o_h
   (&optional __o_h)
   (if __o_h (setq _o_h __o_h)) _o_h)
  (:l_x
   (&optional __l_x)
   (if __l_x (setq _l_x __l_x)) _l_x)
  (:l_y
   (&optional __l_y)
   (if __l_y (setq _l_y __l_y)) _l_y)
  (:l_h
   (&optional __l_h)
   (if __l_h (setq _l_h __l_h)) _l_h)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _h
    4
    ;; float32 _o_x
    4
    ;; float32 _o_y
    4
    ;; float32 _o_h
    4
    ;; float32 _l_x
    4
    ;; float32 _l_y
    4
    ;; float32 _l_h
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _h
       (sys::poke _h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _o_x
       (sys::poke _o_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _o_y
       (sys::poke _o_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _o_h
       (sys::poke _o_h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _l_x
       (sys::poke _l_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _l_y
       (sys::poke _l_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _l_h
       (sys::poke _l_h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _h
     (setq _h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _o_x
     (setq _o_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _o_y
     (setq _o_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _o_h
     (setq _o_h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _l_x
     (setq _l_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _l_y
     (setq _l_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _l_h
     (setq _l_h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get localization::robot_struct :md5sum-) "1e2748a1ebd7e4142014739896b06e16")
(setf (get localization::robot_struct :datatype-) "localization/robot_struct")
(setf (get localization::robot_struct :definition-)
      "Header header
float32 x
float32 y
float32 h
float32 o_x
float32 o_y
float32 o_h
float32 l_x
float32 l_y
float32 l_h
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



(provide :localization/robot_struct "1e2748a1ebd7e4142014739896b06e16")


