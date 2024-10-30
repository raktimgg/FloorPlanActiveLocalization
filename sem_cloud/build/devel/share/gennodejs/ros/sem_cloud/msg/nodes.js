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

//-----------------------------------------------------------

class nodes {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.posesId = null;
      this.poses = null;
    }
    else {
      if (initObj.hasOwnProperty('posesId')) {
        this.posesId = initObj.posesId
      }
      else {
        this.posesId = [];
      }
      if (initObj.hasOwnProperty('poses')) {
        this.poses = initObj.poses
      }
      else {
        this.poses = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type nodes
    // Serialize message field [posesId]
    bufferOffset = _arraySerializer.int32(obj.posesId, buffer, bufferOffset, null);
    // Serialize message field [poses]
    // Serialize the length for message field [poses]
    bufferOffset = _serializer.uint32(obj.poses.length, buffer, bufferOffset);
    obj.poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type nodes
    let len;
    let data = new nodes(null);
    // Deserialize message field [posesId]
    data.posesId = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [poses]
    // Deserialize array length for message field [poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.poses[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.posesId.length;
    length += 56 * object.poses.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sem_cloud/nodes';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0aa0e2793de02d3b5e7aa2ce56d2f367';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32[] posesId
    geometry_msgs/Pose[] poses
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new nodes(null);
    if (msg.posesId !== undefined) {
      resolved.posesId = msg.posesId;
    }
    else {
      resolved.posesId = []
    }

    if (msg.poses !== undefined) {
      resolved.poses = new Array(msg.poses.length);
      for (let i = 0; i < resolved.poses.length; ++i) {
        resolved.poses[i] = geometry_msgs.msg.Pose.Resolve(msg.poses[i]);
      }
    }
    else {
      resolved.poses = []
    }

    return resolved;
    }
};

module.exports = nodes;
