; Auto-generated. Do not edit!


(cl:in-package localization-msg)


;//! \htmlinclude robot_msg.msg.html

(cl:defclass <robot_msg> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type (cl:vector localization-msg:robot_struct)
   :initform (cl:make-array 0 :element-type 'localization-msg:robot_struct :initial-element (cl:make-instance 'localization-msg:robot_struct))))
)

(cl:defclass robot_msg (<robot_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <robot_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'robot_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization-msg:<robot_msg> is deprecated: use localization-msg:robot_msg instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <robot_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:data-val is deprecated.  Use localization-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <robot_msg>) ostream)
  "Serializes a message object of type '<robot_msg>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <robot_msg>) istream)
  "Deserializes a message object of type '<robot_msg>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'localization-msg:robot_struct))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<robot_msg>)))
  "Returns string type for a message object of type '<robot_msg>"
  "localization/robot_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'robot_msg)))
  "Returns string type for a message object of type 'robot_msg"
  "localization/robot_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<robot_msg>)))
  "Returns md5sum for a message object of type '<robot_msg>"
  "9d4446a61247888e26fa88efcb4fe7fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'robot_msg)))
  "Returns md5sum for a message object of type 'robot_msg"
  "9d4446a61247888e26fa88efcb4fe7fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<robot_msg>)))
  "Returns full string definition for message of type '<robot_msg>"
  (cl:format cl:nil "robot_struct[] data~%================================================================================~%MSG: localization/robot_struct~%Header header~%float32 x~%float32 y~%float32 h~%float32 o_x~%float32 o_y~%float32 o_h~%float32 l_x~%float32 l_y~%float32 l_h~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'robot_msg)))
  "Returns full string definition for message of type 'robot_msg"
  (cl:format cl:nil "robot_struct[] data~%================================================================================~%MSG: localization/robot_struct~%Header header~%float32 x~%float32 y~%float32 h~%float32 o_x~%float32 o_y~%float32 o_h~%float32 l_x~%float32 l_y~%float32 l_h~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <robot_msg>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <robot_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'robot_msg
    (cl:cons ':data (data msg))
))
