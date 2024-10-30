// Auto-generated. Do not edit!

// (in-package localization.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let robot_struct = require('./robot_struct.js');

//-----------------------------------------------------------

class robot_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.data = null;
    }
    else {
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type robot_msg
    // Serialize message field [data]
    // Serialize the length for message field [data]
    bufferOffset = _serializer.uint32(obj.data.length, buffer, bufferOffset);
    obj.data.forEach((val) => {
      bufferOffset = robot_struct.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type robot_msg
    let len;
    let data = new robot_msg(null);
    // Deserialize message field [data]
    // Deserialize array length for message field [data]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.data = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.data[i] = robot_struct.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.data.forEach((val) => {
      length += robot_struct.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'localization/robot_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9d4446a61247888e26fa88efcb4fe7fc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    robot_struct[] data
    ================================================================================
    MSG: localization/robot_struct
    Header header
    float32 x
    float32 y
    float32 h
    float32 o_x
    float32 o_y
    float32 o_h
    float32 l_x
    float32 l_y
    float32 l_h
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new robot_msg(null);
    if (msg.data !== undefined) {
      resolved.data = new Array(msg.data.length);
      for (let i = 0; i < resolved.data.length; ++i) {
        resolved.data[i] = robot_struct.Resolve(msg.data[i]);
      }
    }
    else {
      resolved.data = []
    }

    return resolved;
    }
};

module.exports = robot_msg;
