;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::GlobalDescriptor)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'GlobalDescriptor (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::GLOBALDESCRIPTOR")
  (make-package "SEM_CLOUD::GLOBALDESCRIPTOR"))

(in-package "ROS")
;;//! \htmlinclude GlobalDescriptor.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass sem_cloud::GlobalDescriptor
  :super ros::object
  :slots (_header _type _info _data ))

(defmethod sem_cloud::GlobalDescriptor
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) 0)
    ((:info __info) (make-array 0 :initial-element 0 :element-type :char))
    ((:data __data) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _header __header)
   (setq _type (round __type))
   (setq _info __info)
   (setq _data __data)
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
  (:info
   (&optional __info)
   (if __info (setq _info __info)) _info)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _type
    4
    ;; uint8[] _info
    (* 1    (length _info)) 4
    ;; uint8[] _data
    (* 1    (length _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _type
       (write-long _type s)
     ;; uint8[] _info
     (write-long (length _info) s)
     (princ _info s)
     ;; uint8[] _data
     (write-long (length _data) s)
     (princ _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8[] _info
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _info (make-array n :element-type :char))
     (replace _info buf :start2 ptr-) (incf ptr- n))
   ;; uint8[] _data
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _data (make-array n :element-type :char))
     (replace _data buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get sem_cloud::GlobalDescriptor :md5sum-) "cea16e5cbeb4de779e68853766f4772e")
(setf (get sem_cloud::GlobalDescriptor :datatype-) "sem_cloud/GlobalDescriptor")
(setf (get sem_cloud::GlobalDescriptor :definition-)
      "
Header header

# compressed global descriptor
# use rtabmap::util3d::uncompressData() from \"rtabmap/core/util3d.h\"
int32 type
uint8[] info
uint8[] data
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



(provide :sem_cloud/GlobalDescriptor "cea16e5cbeb4de779e68853766f4772e")


