; Auto-generated. Do not edit!


(cl:in-package localization-msg)


;//! \htmlinclude landmark_msg.msg.html

(cl:defclass <landmark_msg> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (data
    :reader data
    :initarg :data
    :type (cl:vector localization-msg:coordinate)
   :initform (cl:make-array 0 :element-type 'localization-msg:coordinate :initial-element (cl:make-instance 'localization-msg:coordinate))))
)

(cl:defclass landmark_msg (<landmark_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <landmark_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'landmark_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization-msg:<landmark_msg> is deprecated: use localization-msg:landmark_msg instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <landmark_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:header-val is deprecated.  Use localization-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <landmark_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:data-val is deprecated.  Use localization-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <landmark_msg>) ostream)
  "Serializes a message object of type '<landmark_msg>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <landmark_msg>) istream)
  "Deserializes a message object of type '<landmark_msg>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'localization-msg:coordinate))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<landmark_msg>)))
  "Returns string type for a message object of type '<landmark_msg>"
  "localization/landmark_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'landmark_msg)))
  "Returns string type for a message object of type 'landmark_msg"
  "localization/landmark_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<landmark_msg>)))
  "Returns md5sum for a message object of type '<landmark_msg>"
  "0a878f29d8b4c5694c345f91a36d88e0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'landmark_msg)))
  "Returns md5sum for a message object of type 'landmark_msg"
  "0a878f29d8b4c5694c345f91a36d88e0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<landmark_msg>)))
  "Returns full string definition for message of type '<landmark_msg>"
  (cl:format cl:nil "Header header~%coordinate[] data~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: localization/coordinate~%float32 x~%float32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'landmark_msg)))
  "Returns full string definition for message of type 'landmark_msg"
  (cl:format cl:nil "Header header~%coordinate[] data~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: localization/coordinate~%float32 x~%float32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <landmark_msg>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <landmark_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'landmark_msg
    (cl:cons ':header (header msg))
    (cl:cons ':data (data msg))
))
