; Auto-generated. Do not edit!


(cl:in-package sem_cloud-msg)


;//! \htmlinclude imagepose.msg.html

(cl:defclass <imagepose> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (rgb
    :reader rgb
    :initarg :rgb
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (depth
    :reader depth
    :initarg :depth
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (semantic
    :reader semantic
    :initarg :semantic
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (poseId
    :reader poseId
    :initarg :poseId
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (pose
    :reader pose
    :initarg :pose
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose)))
   (length
    :reader length
    :initarg :length
    :type cl:integer
    :initform 0)
   (loopclosureId
    :reader loopclosureId
    :initarg :loopclosureId
    :type cl:integer
    :initform 0)
   (proximityDetectionId
    :reader proximityDetectionId
    :initarg :proximityDetectionId
    :type cl:integer
    :initform 0)
   (rtabmapPcl
    :reader rtabmapPcl
    :initarg :rtabmapPcl
    :type sensor_msgs-msg:PointCloud2
    :initform (cl:make-instance 'sensor_msgs-msg:PointCloud2)))
)

(cl:defclass imagepose (<imagepose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <imagepose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'imagepose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sem_cloud-msg:<imagepose> is deprecated: use sem_cloud-msg:imagepose instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:header-val is deprecated.  Use sem_cloud-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'rgb-val :lambda-list '(m))
(cl:defmethod rgb-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:rgb-val is deprecated.  Use sem_cloud-msg:rgb instead.")
  (rgb m))

(cl:ensure-generic-function 'depth-val :lambda-list '(m))
(cl:defmethod depth-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:depth-val is deprecated.  Use sem_cloud-msg:depth instead.")
  (depth m))

(cl:ensure-generic-function 'semantic-val :lambda-list '(m))
(cl:defmethod semantic-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:semantic-val is deprecated.  Use sem_cloud-msg:semantic instead.")
  (semantic m))

(cl:ensure-generic-function 'poseId-val :lambda-list '(m))
(cl:defmethod poseId-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:poseId-val is deprecated.  Use sem_cloud-msg:poseId instead.")
  (poseId m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:pose-val is deprecated.  Use sem_cloud-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:length-val is deprecated.  Use sem_cloud-msg:length instead.")
  (length m))

(cl:ensure-generic-function 'loopclosureId-val :lambda-list '(m))
(cl:defmethod loopclosureId-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:loopclosureId-val is deprecated.  Use sem_cloud-msg:loopclosureId instead.")
  (loopclosureId m))

(cl:ensure-generic-function 'proximityDetectionId-val :lambda-list '(m))
(cl:defmethod proximityDetectionId-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:proximityDetectionId-val is deprecated.  Use sem_cloud-msg:proximityDetectionId instead.")
  (proximityDetectionId m))

(cl:ensure-generic-function 'rtabmapPcl-val :lambda-list '(m))
(cl:defmethod rtabmapPcl-val ((m <imagepose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:rtabmapPcl-val is deprecated.  Use sem_cloud-msg:rtabmapPcl instead.")
  (rtabmapPcl m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <imagepose>) ostream)
  "Serializes a message object of type '<imagepose>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rgb) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'depth) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'semantic) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'poseId))))
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
   (cl:slot-value msg 'poseId))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pose))
  (cl:let* ((signed (cl:slot-value msg 'length)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'loopclosureId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'proximityDetectionId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rtabmapPcl) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <imagepose>) istream)
  "Deserializes a message object of type '<imagepose>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rgb) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'depth) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'semantic) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'poseId) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'poseId)))
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
  (cl:setf (cl:slot-value msg 'pose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pose)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'length) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'loopclosureId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'proximityDetectionId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rtabmapPcl) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<imagepose>)))
  "Returns string type for a message object of type '<imagepose>"
  "sem_cloud/imagepose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'imagepose)))
  "Returns string type for a message object of type 'imagepose"
  "sem_cloud/imagepose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<imagepose>)))
  "Returns md5sum for a message object of type '<imagepose>"
  "7690fb2db9b30a77e74c1a7930e4d8d9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'imagepose)))
  "Returns md5sum for a message object of type 'imagepose"
  "7690fb2db9b30a77e74c1a7930e4d8d9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<imagepose>)))
  "Returns full string definition for message of type '<imagepose>"
  (cl:format cl:nil "Header header~%~%sensor_msgs/Image  rgb~%~%sensor_msgs/Image  depth~%~%sensor_msgs/Image semantic~%~%int32[]              poseId~%~%geometry_msgs/Pose[] pose~%~%int32              length~%~%int32              loopclosureId~%~%int32		    proximityDetectionId~%~%sensor_msgs/PointCloud2 rtabmapPcl~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: sensor_msgs/PointCloud2~%# This message holds a collection of N-dimensional points, which may~%# contain additional information such as normals, intensity, etc. The~%# point data is stored as a binary blob, its layout described by the~%# contents of the \"fields\" array.~%~%# The point cloud data may be organized 2d (image-like) or 1d~%# (unordered). Point clouds organized as 2d images may be produced by~%# camera depth sensors such as stereo or time-of-flight.~%~%# Time of sensor data acquisition, and the coordinate frame ID (for 3d~%# points).~%Header header~%~%# 2D structure of the point cloud. If the cloud is unordered, height is~%# 1 and width is the length of the point cloud.~%uint32 height~%uint32 width~%~%# Describes the channels and their layout in the binary data blob.~%PointField[] fields~%~%bool    is_bigendian # Is this data bigendian?~%uint32  point_step   # Length of a point in bytes~%uint32  row_step     # Length of a row in bytes~%uint8[] data         # Actual point data, size is (row_step*height)~%~%bool is_dense        # True if there are no invalid points~%~%================================================================================~%MSG: sensor_msgs/PointField~%# This message holds the description of one point entry in the~%# PointCloud2 message format.~%uint8 INT8    = 1~%uint8 UINT8   = 2~%uint8 INT16   = 3~%uint8 UINT16  = 4~%uint8 INT32   = 5~%uint8 UINT32  = 6~%uint8 FLOAT32 = 7~%uint8 FLOAT64 = 8~%~%string name      # Name of field~%uint32 offset    # Offset from start of point struct~%uint8  datatype  # Datatype enumeration, see above~%uint32 count     # How many elements in the field~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'imagepose)))
  "Returns full string definition for message of type 'imagepose"
  (cl:format cl:nil "Header header~%~%sensor_msgs/Image  rgb~%~%sensor_msgs/Image  depth~%~%sensor_msgs/Image semantic~%~%int32[]              poseId~%~%geometry_msgs/Pose[] pose~%~%int32              length~%~%int32              loopclosureId~%~%int32		    proximityDetectionId~%~%sensor_msgs/PointCloud2 rtabmapPcl~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: sensor_msgs/PointCloud2~%# This message holds a collection of N-dimensional points, which may~%# contain additional information such as normals, intensity, etc. The~%# point data is stored as a binary blob, its layout described by the~%# contents of the \"fields\" array.~%~%# The point cloud data may be organized 2d (image-like) or 1d~%# (unordered). Point clouds organized as 2d images may be produced by~%# camera depth sensors such as stereo or time-of-flight.~%~%# Time of sensor data acquisition, and the coordinate frame ID (for 3d~%# points).~%Header header~%~%# 2D structure of the point cloud. If the cloud is unordered, height is~%# 1 and width is the length of the point cloud.~%uint32 height~%uint32 width~%~%# Describes the channels and their layout in the binary data blob.~%PointField[] fields~%~%bool    is_bigendian # Is this data bigendian?~%uint32  point_step   # Length of a point in bytes~%uint32  row_step     # Length of a row in bytes~%uint8[] data         # Actual point data, size is (row_step*height)~%~%bool is_dense        # True if there are no invalid points~%~%================================================================================~%MSG: sensor_msgs/PointField~%# This message holds the description of one point entry in the~%# PointCloud2 message format.~%uint8 INT8    = 1~%uint8 UINT8   = 2~%uint8 INT16   = 3~%uint8 UINT16  = 4~%uint8 INT32   = 5~%uint8 UINT32  = 6~%uint8 FLOAT32 = 7~%uint8 FLOAT64 = 8~%~%string name      # Name of field~%uint32 offset    # Offset from start of point struct~%uint8  datatype  # Datatype enumeration, see above~%uint32 count     # How many elements in the field~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <imagepose>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rgb))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'depth))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'semantic))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'poseId) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rtabmapPcl))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <imagepose>))
  "Converts a ROS message object to a list"
  (cl:list 'imagepose
    (cl:cons ':header (header msg))
    (cl:cons ':rgb (rgb msg))
    (cl:cons ':depth (depth msg))
    (cl:cons ':semantic (semantic msg))
    (cl:cons ':poseId (poseId msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':length (length msg))
    (cl:cons ':loopclosureId (loopclosureId msg))
    (cl:cons ':proximityDetectionId (proximityDetectionId msg))
    (cl:cons ':rtabmapPcl (rtabmapPcl msg))
))
