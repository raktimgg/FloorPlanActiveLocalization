; Auto-generated. Do not edit!


(cl:in-package sem_cloud-msg)


;//! \htmlinclude robot_struct.msg.html

(cl:defclass <robot_struct> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (h
    :reader h
    :initarg :h
    :type cl:float
    :initform 0.0)
   (o_x
    :reader o_x
    :initarg :o_x
    :type cl:float
    :initform 0.0)
   (o_y
    :reader o_y
    :initarg :o_y
    :type cl:float
    :initform 0.0)
   (o_h
    :reader o_h
    :initarg :o_h
    :type cl:float
    :initform 0.0)
   (l_x
    :reader l_x
    :initarg :l_x
    :type cl:float
    :initform 0.0)
   (l_y
    :reader l_y
    :initarg :l_y
    :type cl:float
    :initform 0.0)
   (l_h
    :reader l_h
    :initarg :l_h
    :type cl:float
    :initform 0.0))
)

(cl:defclass robot_struct (<robot_struct>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <robot_struct>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'robot_struct)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sem_cloud-msg:<robot_struct> is deprecated: use sem_cloud-msg:robot_struct instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:header-val is deprecated.  Use sem_cloud-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:x-val is deprecated.  Use sem_cloud-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:y-val is deprecated.  Use sem_cloud-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'h-val :lambda-list '(m))
(cl:defmethod h-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:h-val is deprecated.  Use sem_cloud-msg:h instead.")
  (h m))

(cl:ensure-generic-function 'o_x-val :lambda-list '(m))
(cl:defmethod o_x-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:o_x-val is deprecated.  Use sem_cloud-msg:o_x instead.")
  (o_x m))

(cl:ensure-generic-function 'o_y-val :lambda-list '(m))
(cl:defmethod o_y-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:o_y-val is deprecated.  Use sem_cloud-msg:o_y instead.")
  (o_y m))

(cl:ensure-generic-function 'o_h-val :lambda-list '(m))
(cl:defmethod o_h-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:o_h-val is deprecated.  Use sem_cloud-msg:o_h instead.")
  (o_h m))

(cl:ensure-generic-function 'l_x-val :lambda-list '(m))
(cl:defmethod l_x-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:l_x-val is deprecated.  Use sem_cloud-msg:l_x instead.")
  (l_x m))

(cl:ensure-generic-function 'l_y-val :lambda-list '(m))
(cl:defmethod l_y-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:l_y-val is deprecated.  Use sem_cloud-msg:l_y instead.")
  (l_y m))

(cl:ensure-generic-function 'l_h-val :lambda-list '(m))
(cl:defmethod l_h-val ((m <robot_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:l_h-val is deprecated.  Use sem_cloud-msg:l_h instead.")
  (l_h m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <robot_struct>) ostream)
  "Serializes a message object of type '<robot_struct>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'h))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'o_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'o_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'o_h))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'l_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'l_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'l_h))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <robot_struct>) istream)
  "Deserializes a message object of type '<robot_struct>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'h) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'o_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'o_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'o_h) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'l_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'l_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'l_h) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<robot_struct>)))
  "Returns string type for a message object of type '<robot_struct>"
  "sem_cloud/robot_struct")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'robot_struct)))
  "Returns string type for a message object of type 'robot_struct"
  "sem_cloud/robot_struct")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<robot_struct>)))
  "Returns md5sum for a message object of type '<robot_struct>"
  "1e2748a1ebd7e4142014739896b06e16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'robot_struct)))
  "Returns md5sum for a message object of type 'robot_struct"
  "1e2748a1ebd7e4142014739896b06e16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<robot_struct>)))
  "Returns full string definition for message of type '<robot_struct>"
  (cl:format cl:nil "Header header~%float32 x~%float32 y~%float32 h~%float32 o_x~%float32 o_y~%float32 o_h~%float32 l_x~%float32 l_y~%float32 l_h~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'robot_struct)))
  "Returns full string definition for message of type 'robot_struct"
  (cl:format cl:nil "Header header~%float32 x~%float32 y~%float32 h~%float32 o_x~%float32 o_y~%float32 o_h~%float32 l_x~%float32 l_y~%float32 l_h~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <robot_struct>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <robot_struct>))
  "Converts a ROS message object to a list"
  (cl:list 'robot_struct
    (cl:cons ':header (header msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':h (h msg))
    (cl:cons ':o_x (o_x msg))
    (cl:cons ':o_y (o_y msg))
    (cl:cons ':o_h (o_h msg))
    (cl:cons ':l_x (l_x msg))
    (cl:cons ':l_y (l_y msg))
    (cl:cons ':l_h (l_h msg))
))
