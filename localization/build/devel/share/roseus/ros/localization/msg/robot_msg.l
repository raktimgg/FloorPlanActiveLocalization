;; Auto-generated. Do not edit!


(when (boundp 'localization::robot_msg)
  (if (not (find-package "LOCALIZATION"))
    (make-package "LOCALIZATION"))
  (shadow 'robot_msg (find-package "LOCALIZATION")))
(unless (find-package "LOCALIZATION::ROBOT_MSG")
  (make-package "LOCALIZATION::ROBOT_MSG"))

(in-package "ROS")
;;//! \htmlinclude robot_msg.msg.html


(defclass localization::robot_msg
  :super ros::object
  :slots (_data ))

(defmethod localization::robot_msg
  (:init
   (&key
    ((:data __data) ())
    )
   (send-super :init)
   (setq _data __data)
   self)
  (:data
   (&rest __data)
   (if (keywordp (car __data))
       (send* _data __data)
     (progn
       (if __data (setq _data (car __data)))
       _data)))
  (:serialization-length
   ()
   (+
    ;; localization/robot_struct[] _data
    (apply #'+ (send-all _data :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; localization/robot_struct[] _data
     (write-long (length _data) s)
     (dolist (elem _data)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; localization/robot_struct[] _data
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _data (let (r) (dotimes (i n) (push (instance localization::robot_struct :init) r)) r))
     (dolist (elem- _data)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get localization::robot_msg :md5sum-) "9d4446a61247888e26fa88efcb4fe7fc")
(setf (get localization::robot_msg :datatype-) "localization/robot_msg")
(setf (get localization::robot_msg :definition-)
      "robot_struct[] data
================================================================================
MSG: localization/robot_struct
Header header
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



(provide :localization/robot_msg "9d4446a61247888e26fa88efcb4fe7fc")


