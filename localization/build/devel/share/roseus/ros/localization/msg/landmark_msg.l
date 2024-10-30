;; Auto-generated. Do not edit!


(when (boundp 'localization::landmark_msg)
  (if (not (find-package "LOCALIZATION"))
    (make-package "LOCALIZATION"))
  (shadow 'landmark_msg (find-package "LOCALIZATION")))
(unless (find-package "LOCALIZATION::LANDMARK_MSG")
  (make-package "LOCALIZATION::LANDMARK_MSG"))

(in-package "ROS")
;;//! \htmlinclude landmark_msg.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass localization::landmark_msg
  :super ros::object
  :slots (_header _data ))

(defmethod localization::landmark_msg
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:data __data) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _data __data)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
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
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; localization/coordinate[] _data
    (apply #'+ (send-all _data :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; localization/coordinate[] _data
     (write-long (length _data) s)
     (dolist (elem _data)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; localization/coordinate[] _data
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _data (let (r) (dotimes (i n) (push (instance localization::coordinate :init) r)) r))
     (dolist (elem- _data)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get localization::landmark_msg :md5sum-) "0a878f29d8b4c5694c345f91a36d88e0")
(setf (get localization::landmark_msg :datatype-) "localization/landmark_msg")
(setf (get localization::landmark_msg :definition-)
      "Header header
coordinate[] data
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

================================================================================
MSG: localization/coordinate
float32 x
float32 y
")



(provide :localization/landmark_msg "0a878f29d8b4c5694c345f91a36d88e0")


