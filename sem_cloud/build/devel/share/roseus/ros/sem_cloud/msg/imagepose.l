;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::imagepose)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'imagepose (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::IMAGEPOSE")
  (make-package "SEM_CLOUD::IMAGEPOSE"))

(in-package "ROS")
;;//! \htmlinclude imagepose.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass sem_cloud::imagepose
  :super ros::object
  :slots (_header _rgb _depth _semantic _poseId _pose _length _loopclosureId _proximityDetectionId _rtabmapPcl ))

(defmethod sem_cloud::imagepose
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rgb __rgb) (instance sensor_msgs::Image :init))
    ((:depth __depth) (instance sensor_msgs::Image :init))
    ((:semantic __semantic) (instance sensor_msgs::Image :init))
    ((:poseId __poseId) (make-array 0 :initial-element 0 :element-type :integer))
    ((:pose __pose) ())
    ((:length __length) 0)
    ((:loopclosureId __loopclosureId) 0)
    ((:proximityDetectionId __proximityDetectionId) 0)
    ((:rtabmapPcl __rtabmapPcl) (instance sensor_msgs::PointCloud2 :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _rgb __rgb)
   (setq _depth __depth)
   (setq _semantic __semantic)
   (setq _poseId __poseId)
   (setq _pose __pose)
   (setq _length (round __length))
   (setq _loopclosureId (round __loopclosureId))
   (setq _proximityDetectionId (round __proximityDetectionId))
   (setq _rtabmapPcl __rtabmapPcl)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rgb
   (&rest __rgb)
   (if (keywordp (car __rgb))
       (send* _rgb __rgb)
     (progn
       (if __rgb (setq _rgb (car __rgb)))
       _rgb)))
  (:depth
   (&rest __depth)
   (if (keywordp (car __depth))
       (send* _depth __depth)
     (progn
       (if __depth (setq _depth (car __depth)))
       _depth)))
  (:semantic
   (&rest __semantic)
   (if (keywordp (car __semantic))
       (send* _semantic __semantic)
     (progn
       (if __semantic (setq _semantic (car __semantic)))
       _semantic)))
  (:poseId
   (&optional __poseId)
   (if __poseId (setq _poseId __poseId)) _poseId)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:loopclosureId
   (&optional __loopclosureId)
   (if __loopclosureId (setq _loopclosureId __loopclosureId)) _loopclosureId)
  (:proximityDetectionId
   (&optional __proximityDetectionId)
   (if __proximityDetectionId (setq _proximityDetectionId __proximityDetectionId)) _proximityDetectionId)
  (:rtabmapPcl
   (&rest __rtabmapPcl)
   (if (keywordp (car __rtabmapPcl))
       (send* _rtabmapPcl __rtabmapPcl)
     (progn
       (if __rtabmapPcl (setq _rtabmapPcl (car __rtabmapPcl)))
       _rtabmapPcl)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; sensor_msgs/Image _rgb
    (send _rgb :serialization-length)
    ;; sensor_msgs/Image _depth
    (send _depth :serialization-length)
    ;; sensor_msgs/Image _semantic
    (send _semantic :serialization-length)
    ;; int32[] _poseId
    (* 4    (length _poseId)) 4
    ;; geometry_msgs/Pose[] _pose
    (apply #'+ (send-all _pose :serialization-length)) 4
    ;; int32 _length
    4
    ;; int32 _loopclosureId
    4
    ;; int32 _proximityDetectionId
    4
    ;; sensor_msgs/PointCloud2 _rtabmapPcl
    (send _rtabmapPcl :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; sensor_msgs/Image _rgb
       (send _rgb :serialize s)
     ;; sensor_msgs/Image _depth
       (send _depth :serialize s)
     ;; sensor_msgs/Image _semantic
       (send _semantic :serialize s)
     ;; int32[] _poseId
     (write-long (length _poseId) s)
     (dotimes (i (length _poseId))
       (write-long (elt _poseId i) s)
       )
     ;; geometry_msgs/Pose[] _pose
     (write-long (length _pose) s)
     (dolist (elem _pose)
       (send elem :serialize s)
       )
     ;; int32 _length
       (write-long _length s)
     ;; int32 _loopclosureId
       (write-long _loopclosureId s)
     ;; int32 _proximityDetectionId
       (write-long _proximityDetectionId s)
     ;; sensor_msgs/PointCloud2 _rtabmapPcl
       (send _rtabmapPcl :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; sensor_msgs/Image _rgb
     (send _rgb :deserialize buf ptr-) (incf ptr- (send _rgb :serialization-length))
   ;; sensor_msgs/Image _depth
     (send _depth :deserialize buf ptr-) (incf ptr- (send _depth :serialization-length))
   ;; sensor_msgs/Image _semantic
     (send _semantic :deserialize buf ptr-) (incf ptr- (send _semantic :serialization-length))
   ;; int32[] _poseId
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poseId (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _poseId i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; geometry_msgs/Pose[] _pose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pose (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _pose)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32 _length
     (setq _length (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _loopclosureId
     (setq _loopclosureId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _proximityDetectionId
     (setq _proximityDetectionId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; sensor_msgs/PointCloud2 _rtabmapPcl
     (send _rtabmapPcl :deserialize buf ptr-) (incf ptr- (send _rtabmapPcl :serialization-length))
   ;;
   self)
  )

(setf (get sem_cloud::imagepose :md5sum-) "7690fb2db9b30a77e74c1a7930e4d8d9")
(setf (get sem_cloud::imagepose :datatype-) "sem_cloud/imagepose")
(setf (get sem_cloud::imagepose :definition-)
      "Header header

sensor_msgs/Image  rgb

sensor_msgs/Image  depth

sensor_msgs/Image semantic

int32[]              poseId

geometry_msgs/Pose[] pose

int32              length

int32              loopclosureId

int32		    proximityDetectionId

sensor_msgs/PointCloud2 rtabmapPcl

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

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: sensor_msgs/PointCloud2
# This message holds a collection of N-dimensional points, which may
# contain additional information such as normals, intensity, etc. The
# point data is stored as a binary blob, its layout described by the
# contents of the \"fields\" array.

# The point cloud data may be organized 2d (image-like) or 1d
# (unordered). Point clouds organized as 2d images may be produced by
# camera depth sensors such as stereo or time-of-flight.

# Time of sensor data acquisition, and the coordinate frame ID (for 3d
# points).
Header header

# 2D structure of the point cloud. If the cloud is unordered, height is
# 1 and width is the length of the point cloud.
uint32 height
uint32 width

# Describes the channels and their layout in the binary data blob.
PointField[] fields

bool    is_bigendian # Is this data bigendian?
uint32  point_step   # Length of a point in bytes
uint32  row_step     # Length of a row in bytes
uint8[] data         # Actual point data, size is (row_step*height)

bool is_dense        # True if there are no invalid points

================================================================================
MSG: sensor_msgs/PointField
# This message holds the description of one point entry in the
# PointCloud2 message format.
uint8 INT8    = 1
uint8 UINT8   = 2
uint8 INT16   = 3
uint8 UINT16  = 4
uint8 INT32   = 5
uint8 UINT32  = 6
uint8 FLOAT32 = 7
uint8 FLOAT64 = 8

string name      # Name of field
uint32 offset    # Offset from start of point struct
uint8  datatype  # Datatype enumeration, see above
uint32 count     # How many elements in the field

")



(provide :sem_cloud/imagepose "7690fb2db9b30a77e74c1a7930e4d8d9")


