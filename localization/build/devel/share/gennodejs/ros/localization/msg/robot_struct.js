// Auto-generated. Do not edit!

// (in-package localization.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class robot_struct {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.x = null;
      this.y = null;
      this.h = null;
      this.o_x = null;
      this.o_y = null;
      this.o_h = null;
      this.l_x = null;
      this.l_y = null;
      this.l_h = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0.0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0.0;
      }
      if (initObj.hasOwnProperty('h')) {
        this.h = initObj.h
      }
      else {
        this.h = 0.0;
      }
      if (initObj.hasOwnProperty('o_x')) {
        this.o_x = initObj.o_x
      }
      else {
        this.o_x = 0.0;
      }
      if (initObj.hasOwnProperty('o_y')) {
        this.o_y = initObj.o_y
      }
      else {
        this.o_y = 0.0;
      }
      if (initObj.hasOwnProperty('o_h')) {
        this.o_h = initObj.o_h
      }
      else {
        this.o_h = 0.0;
      }
      if (initObj.hasOwnProperty('l_x')) {
        this.l_x = initObj.l_x
      }
      else {
        this.l_x = 0.0;
      }
      if (initObj.hasOwnProperty('l_y')) {
        this.l_y = initObj.l_y
      }
      else {
        this.l_y = 0.0;
      }
      if (initObj.hasOwnProperty('l_h')) {
        this.l_h = initObj.l_h
      }
      else {
        this.l_h = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type robot_struct
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float32(obj.y, buffer, bufferOffset);
    // Serialize message field [h]
    bufferOffset = _serializer.float32(obj.h, buffer, bufferOffset);
    // Serialize message field [o_x]
    bufferOffset = _serializer.float32(obj.o_x, buffer, bufferOffset);
    // Serialize message field [o_y]
    bufferOffset = _serializer.float32(obj.o_y, buffer, bufferOffset);
    // Serialize message field [o_h]
    bufferOffset = _serializer.float32(obj.o_h, buffer, bufferOffset);
    // Serialize message field [l_x]
    bufferOffset = _serializer.float32(obj.l_x, buffer, bufferOffset);
    // Serialize message field [l_y]
    bufferOffset = _serializer.float32(obj.l_y, buffer, bufferOffset);
    // Serialize message field [l_h]
    bufferOffset = _serializer.float32(obj.l_h, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type robot_struct
    let len;
    let data = new robot_struct(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [h]
    data.h = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [o_x]
    data.o_x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [o_y]
    data.o_y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [o_h]
    data.o_h = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [l_x]
    data.l_x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [l_y]
    data.l_y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [l_h]
    data.l_h = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'localization/robot_struct';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1e2748a1ebd7e4142014739896b06e16';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new robot_struct(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0.0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0.0
    }

    if (msg.h !== undefined) {
      resolved.h = msg.h;
    }
    else {
      resolved.h = 0.0
    }

    if (msg.o_x !== undefined) {
      resolved.o_x = msg.o_x;
    }
    else {
      resolved.o_x = 0.0
    }

    if (msg.o_y !== undefined) {
      resolved.o_y = msg.o_y;
    }
    else {
      resolved.o_y = 0.0
    }

    if (msg.o_h !== undefined) {
      resolved.o_h = msg.o_h;
    }
    else {
      resolved.o_h = 0.0
    }

    if (msg.l_x !== undefined) {
      resolved.l_x = msg.l_x;
    }
    else {
      resolved.l_x = 0.0
    }

    if (msg.l_y !== undefined) {
      resolved.l_y = msg.l_y;
    }
    else {
      resolved.l_y = 0.0
    }

    if (msg.l_h !== undefined) {
      resolved.l_h = msg.l_h;
    }
    else {
      resolved.l_h = 0.0
    }

    return resolved;
    }
};

module.exports = robot_struct;
