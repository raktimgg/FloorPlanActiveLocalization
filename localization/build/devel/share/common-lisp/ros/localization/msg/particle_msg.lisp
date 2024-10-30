; Auto-generated. Do not edit!


(cl:in-package localization-msg)


;//! \htmlinclude particle_msg.msg.html

(cl:defclass <particle_msg> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (data
    :reader data
    :initarg :data
    :type (cl:vector localization-msg:particle_struct)
   :initform (cl:make-array 0 :element-type 'localization-msg:particle_struct :initial-element (cl:make-instance 'localization-msg:particle_struct))))
)

(cl:defclass particle_msg (<particle_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <particle_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'particle_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization-msg:<particle_msg> is deprecated: use localization-msg:particle_msg instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <particle_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:header-val is deprecated.  Use localization-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <particle_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:data-val is deprecated.  Use localization-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <particle_msg>) ostream)
  "Serializes a message object of type '<particle_msg>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <particle_msg>) istream)
  "Deserializes a message object of type '<particle_msg>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'localization-msg:particle_struct))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<particle_msg>)))
  "Returns string type for a message object of type '<particle_msg>"
  "localization/particle_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'particle_msg)))
  "Returns string type for a message object of type 'particle_msg"
  "localization/particle_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<particle_msg>)))
  "Returns md5sum for a message object of type '<particle_msg>"
  "bd556db35b7bbf1b8788da0e832d2d7a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'particle_msg)))
  "Returns md5sum for a message object of type 'particle_msg"
  "bd556db35b7bbf1b8788da0e832d2d7a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<particle_msg>)))
  "Returns full string definition for message of type '<particle_msg>"
  (cl:format cl:nil "Header header~%particle_struct[] data~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: localization/particle_struct~%float32 x~%float32 y~%float32 h~%float32 w~%float32 perc~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'particle_msg)))
  "Returns full string definition for message of type 'particle_msg"
  (cl:format cl:nil "Header header~%particle_struct[] data~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: localization/particle_struct~%float32 x~%float32 y~%float32 h~%float32 w~%float32 perc~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <particle_msg>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <particle_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'particle_msg
    (cl:cons ':header (header msg))
    (cl:cons ':data (data msg))
))
