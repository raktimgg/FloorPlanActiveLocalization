;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::commandsafe)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'commandsafe (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::COMMANDSAFE")
  (make-package "SEM_CLOUD::COMMANDSAFE"))

(in-package "ROS")
;;//! \htmlinclude commandsafe.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass sem_cloud::commandsafe
  :super ros::object
  :slots (_header _left _right _straight _back ))

(defmethod sem_cloud::commandsafe
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:left __left) 0)
    ((:right __right) 0)
    ((:straight __straight) 0)
    ((:back __back) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _left (round __left))
   (setq _right (round __right))
   (setq _straight (round __straight))
   (setq _back (round __back))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:right
   (&optional __right)
   (if __right (setq _right __right)) _right)
  (:straight
   (&optional __straight)
   (if __straight (setq _straight __straight)) _straight)
  (:back
   (&optional __back)
   (if __back (setq _back __back)) _back)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _left
    4
    ;; int32 _right
    4
    ;; int32 _straight
    4
    ;; int32 _back
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _left
       (write-long _left s)
     ;; int32 _right
       (write-long _right s)
     ;; int32 _straight
       (write-long _straight s)
     ;; int32 _back
       (write-long _back s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _left
     (setq _left (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _right
     (setq _right (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _straight
     (setq _straight (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _back
     (setq _back (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get sem_cloud::commandsafe :md5sum-) "533853f234cec6a8db3c27969d1da989")
(setf (get sem_cloud::commandsafe :datatype-) "sem_cloud/commandsafe")
(setf (get sem_cloud::commandsafe :definition-)
      "Header header
int32 left
int32 right
int32 straight
int32 back


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



(provide :sem_cloud/commandsafe "533853f234cec6a8db3c27969d1da989")


