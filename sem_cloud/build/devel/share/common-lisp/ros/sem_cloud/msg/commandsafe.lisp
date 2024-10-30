; Auto-generated. Do not edit!


(cl:in-package sem_cloud-msg)


;//! \htmlinclude commandsafe.msg.html

(cl:defclass <commandsafe> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (left
    :reader left
    :initarg :left
    :type cl:integer
    :initform 0)
   (right
    :reader right
    :initarg :right
    :type cl:integer
    :initform 0)
   (straight
    :reader straight
    :initarg :straight
    :type cl:integer
    :initform 0)
   (back
    :reader back
    :initarg :back
    :type cl:integer
    :initform 0))
)

(cl:defclass commandsafe (<commandsafe>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <commandsafe>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'commandsafe)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sem_cloud-msg:<commandsafe> is deprecated: use sem_cloud-msg:commandsafe instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <commandsafe>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:header-val is deprecated.  Use sem_cloud-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <commandsafe>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:left-val is deprecated.  Use sem_cloud-msg:left instead.")
  (left m))

(cl:ensure-generic-function 'right-val :lambda-list '(m))
(cl:defmethod right-val ((m <commandsafe>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:right-val is deprecated.  Use sem_cloud-msg:right instead.")
  (right m))

(cl:ensure-generic-function 'straight-val :lambda-list '(m))
(cl:defmethod straight-val ((m <commandsafe>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:straight-val is deprecated.  Use sem_cloud-msg:straight instead.")
  (straight m))

(cl:ensure-generic-function 'back-val :lambda-list '(m))
(cl:defmethod back-val ((m <commandsafe>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:back-val is deprecated.  Use sem_cloud-msg:back instead.")
  (back m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <commandsafe>) ostream)
  "Serializes a message object of type '<commandsafe>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'left)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'right)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'straight)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'back)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <commandsafe>) istream)
  "Deserializes a message object of type '<commandsafe>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'left) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'right) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'straight) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'back) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<commandsafe>)))
  "Returns string type for a message object of type '<commandsafe>"
  "sem_cloud/commandsafe")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'commandsafe)))
  "Returns string type for a message object of type 'commandsafe"
  "sem_cloud/commandsafe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<commandsafe>)))
  "Returns md5sum for a message object of type '<commandsafe>"
  "533853f234cec6a8db3c27969d1da989")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'commandsafe)))
  "Returns md5sum for a message object of type 'commandsafe"
  "533853f234cec6a8db3c27969d1da989")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<commandsafe>)))
  "Returns full string definition for message of type '<commandsafe>"
  (cl:format cl:nil "Header header~%int32 left~%int32 right~%int32 straight~%int32 back~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'commandsafe)))
  "Returns full string definition for message of type 'commandsafe"
  (cl:format cl:nil "Header header~%int32 left~%int32 right~%int32 straight~%int32 back~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <commandsafe>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <commandsafe>))
  "Converts a ROS message object to a list"
  (cl:list 'commandsafe
    (cl:cons ':header (header msg))
    (cl:cons ':left (left msg))
    (cl:cons ':right (right msg))
    (cl:cons ':straight (straight msg))
    (cl:cons ':back (back msg))
))
