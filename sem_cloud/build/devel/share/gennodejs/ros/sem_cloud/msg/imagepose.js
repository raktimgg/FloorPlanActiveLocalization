// Auto-generated. Do not edit!

// (in-package sem_cloud.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');
let sensor_msgs = _finder('sensor_msgs');

//-----------------------------------------------------------

class imagepose {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.rgb = null;
      this.depth = null;
      this.semantic = null;
      this.poseId = null;
      this.pose = null;
      this.length = null;
      this.loopclosureId = null;
      this.proximityDetectionId = null;
      this.rtabmapPcl = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('rgb')) {
        this.rgb = initObj.rgb
      }
      else {
        this.rgb = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('depth')) {
        this.depth = initObj.depth
      }
      else {
        this.depth = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('semantic')) {
        this.semantic = initObj.semantic
      }
      else {
        this.semantic = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('poseId')) {
        this.poseId = initObj.poseId
      }
      else {
        this.poseId = [];
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = [];
      }
      if (initObj.hasOwnProperty('length')) {
        this.length = initObj.length
      }
      else {
        this.length = 0;
      }
      if (initObj.hasOwnProperty('loopclosureId')) {
        this.loopclosureId = initObj.loopclosureId
      }
      else {
        this.loopclosureId = 0;
      }
      if (initObj.hasOwnProperty('proximityDetectionId')) {
        this.proximityDetectionId = initObj.proximityDetectionId
      }
      else {
        this.proximityDetectionId = 0;
      }
      if (initObj.hasOwnProperty('rtabmapPcl')) {
        this.rtabmapPcl = initObj.rtabmapPcl
      }
      else {
        this.rtabmapPcl = new sensor_msgs.msg.PointCloud2();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type imagepose
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [rgb]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.rgb, buffer, bufferOffset);
    // Serialize message field [depth]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.depth, buffer, bufferOffset);
    // Serialize message field [semantic]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.semantic, buffer, bufferOffset);
    // Serialize message field [poseId]
    bufferOffset = _arraySerializer.int32(obj.poseId, buffer, bufferOffset, null);
    // Serialize message field [pose]
    // Serialize the length for message field [pose]
    bufferOffset = _serializer.uint32(obj.pose.length, buffer, bufferOffset);
    obj.pose.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [length]
    bufferOffset = _serializer.int32(obj.length, buffer, bufferOffset);
    // Serialize message field [loopclosureId]
    bufferOffset = _serializer.int32(obj.loopclosureId, buffer, bufferOffset);
    // Serialize message field [proximityDetectionId]
    bufferOffset = _serializer.int32(obj.proximityDetectionId, buffer, bufferOffset);
    // Serialize message field [rtabmapPcl]
    bufferOffset = sensor_msgs.msg.PointCloud2.serialize(obj.rtabmapPcl, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type imagepose
    let len;
    let data = new imagepose(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [rgb]
    data.rgb = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [depth]
    data.depth = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [semantic]
    data.semantic = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [poseId]
    data.poseId = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [pose]
    // Deserialize array length for message field [pose]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.pose = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.pose[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [length]
    data.length = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [loopclosureId]
    data.loopclosureId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [proximityDetectionId]
    data.proximityDetectionId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [rtabmapPcl]
    data.rtabmapPcl = sensor_msgs.msg.PointCloud2.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += sensor_msgs.msg.Image.getMessageSize(object.rgb);
    length += sensor_msgs.msg.Image.getMessageSize(object.depth);
    length += sensor_msgs.msg.Image.getMessageSize(object.semantic);
    length += 4 * object.poseId.length;
    length += 56 * object.pose.length;
    length += sensor_msgs.msg.PointCloud2.getMessageSize(object.rtabmapPcl);
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sem_cloud/imagepose';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7690fb2db9b30a77e74c1a7930e4d8d9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
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
    # contents of the "fields" array.
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new imagepose(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.rgb !== undefined) {
      resolved.rgb = sensor_msgs.msg.Image.Resolve(msg.rgb)
    }
    else {
      resolved.rgb = new sensor_msgs.msg.Image()
    }

    if (msg.depth !== undefined) {
      resolved.depth = sensor_msgs.msg.Image.Resolve(msg.depth)
    }
    else {
      resolved.depth = new sensor_msgs.msg.Image()
    }

    if (msg.semantic !== undefined) {
      resolved.semantic = sensor_msgs.msg.Image.Resolve(msg.semantic)
    }
    else {
      resolved.semantic = new sensor_msgs.msg.Image()
    }

    if (msg.poseId !== undefined) {
      resolved.poseId = msg.poseId;
    }
    else {
      resolved.poseId = []
    }

    if (msg.pose !== undefined) {
      resolved.pose = new Array(msg.pose.length);
      for (let i = 0; i < resolved.pose.length; ++i) {
        resolved.pose[i] = geometry_msgs.msg.Pose.Resolve(msg.pose[i]);
      }
    }
    else {
      resolved.pose = []
    }

    if (msg.length !== undefined) {
      resolved.length = msg.length;
    }
    else {
      resolved.length = 0
    }

    if (msg.loopclosureId !== undefined) {
      resolved.loopclosureId = msg.loopclosureId;
    }
    else {
      resolved.loopclosureId = 0
    }

    if (msg.proximityDetectionId !== undefined) {
      resolved.proximityDetectionId = msg.proximityDetectionId;
    }
    else {
      resolved.proximityDetectionId = 0
    }

    if (msg.rtabmapPcl !== undefined) {
      resolved.rtabmapPcl = sensor_msgs.msg.PointCloud2.Resolve(msg.rtabmapPcl)
    }
    else {
      resolved.rtabmapPcl = new sensor_msgs.msg.PointCloud2()
    }

    return resolved;
    }
};

module.exports = imagepose;
