; Auto-generated. Do not edit!


(cl:in-package sem_cloud-msg)


;//! \htmlinclude rds.msg.html

(cl:defclass <rds> (roslisp-msg-protocol:ros-message)
  ((rgb
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
    :type sem_cloud-msg:Semantic
    :initform (cl:make-instance 'sem_cloud-msg:Semantic)))
)

(cl:defclass rds (<rds>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <rds>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'rds)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sem_cloud-msg:<rds> is deprecated: use sem_cloud-msg:rds instead.")))

(cl:ensure-generic-function 'rgb-val :lambda-list '(m))
(cl:defmethod rgb-val ((m <rds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:rgb-val is deprecated.  Use sem_cloud-msg:rgb instead.")
  (rgb m))

(cl:ensure-generic-function 'depth-val :lambda-list '(m))
(cl:defmethod depth-val ((m <rds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:depth-val is deprecated.  Use sem_cloud-msg:depth instead.")
  (depth m))

(cl:ensure-generic-function 'semantic-val :lambda-list '(m))
(cl:defmethod semantic-val ((m <rds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:semantic-val is deprecated.  Use sem_cloud-msg:semantic instead.")
  (semantic m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <rds>) ostream)
  "Serializes a message object of type '<rds>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rgb) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'depth) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'semantic) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <rds>) istream)
  "Deserializes a message object of type '<rds>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rgb) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'depth) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'semantic) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<rds>)))
  "Returns string type for a message object of type '<rds>"
  "sem_cloud/rds")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rds)))
  "Returns string type for a message object of type 'rds"
  "sem_cloud/rds")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<rds>)))
  "Returns md5sum for a message object of type '<rds>"
  "ada45110d9d786576b747e09320e468d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'rds)))
  "Returns md5sum for a message object of type 'rds"
  "ada45110d9d786576b747e09320e468d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<rds>)))
  "Returns full string definition for message of type '<rds>"
  (cl:format cl:nil "sensor_msgs/Image  rgb~%~%sensor_msgs/Image  depth~%~%sem_cloud/Semantic semantic~%~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sem_cloud/Semantic~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%int32[] data          # actual matrix data, size is (step * rows)~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'rds)))
  "Returns full string definition for message of type 'rds"
  (cl:format cl:nil "sensor_msgs/Image  rgb~%~%sensor_msgs/Image  depth~%~%sem_cloud/Semantic semantic~%~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sem_cloud/Semantic~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%int32[] data          # actual matrix data, size is (step * rows)~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <rds>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rgb))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'depth))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'semantic))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <rds>))
  "Converts a ROS message object to a list"
  (cl:list 'rds
    (cl:cons ':rgb (rgb msg))
    (cl:cons ':depth (depth msg))
    (cl:cons ':semantic (semantic msg))
))
