; Auto-generated. Do not edit!


(cl:in-package sem_cloud-msg)


;//! \htmlinclude nodes.msg.html

(cl:defclass <nodes> (roslisp-msg-protocol:ros-message)
  ((posesId
    :reader posesId
    :initarg :posesId
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (poses
    :reader poses
    :initarg :poses
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass nodes (<nodes>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <nodes>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'nodes)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sem_cloud-msg:<nodes> is deprecated: use sem_cloud-msg:nodes instead.")))

(cl:ensure-generic-function 'posesId-val :lambda-list '(m))
(cl:defmethod posesId-val ((m <nodes>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:posesId-val is deprecated.  Use sem_cloud-msg:posesId instead.")
  (posesId m))

(cl:ensure-generic-function 'poses-val :lambda-list '(m))
(cl:defmethod poses-val ((m <nodes>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:poses-val is deprecated.  Use sem_cloud-msg:poses instead.")
  (poses m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <nodes>) ostream)
  "Serializes a message object of type '<nodes>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'posesId))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'posesId))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'poses))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <nodes>) istream)
  "Deserializes a message object of type '<nodes>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'posesId) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'posesId)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'poses) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'poses)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<nodes>)))
  "Returns string type for a message object of type '<nodes>"
  "sem_cloud/nodes")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'nodes)))
  "Returns string type for a message object of type 'nodes"
  "sem_cloud/nodes")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<nodes>)))
  "Returns md5sum for a message object of type '<nodes>"
  "0aa0e2793de02d3b5e7aa2ce56d2f367")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'nodes)))
  "Returns md5sum for a message object of type 'nodes"
  "0aa0e2793de02d3b5e7aa2ce56d2f367")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<nodes>)))
  "Returns full string definition for message of type '<nodes>"
  (cl:format cl:nil "int32[] posesId~%geometry_msgs/Pose[] poses~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'nodes)))
  "Returns full string definition for message of type 'nodes"
  (cl:format cl:nil "int32[] posesId~%geometry_msgs/Pose[] poses~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <nodes>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'posesId) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <nodes>))
  "Converts a ROS message object to a list"
  (cl:list 'nodes
    (cl:cons ':posesId (posesId msg))
    (cl:cons ':poses (poses msg))
))
