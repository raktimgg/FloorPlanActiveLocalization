// Auto-generated. Do not edit!

// (in-package localization.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class particle_struct {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.x = null;
      this.y = null;
      this.h = null;
      this.w = null;
      this.perc = null;
    }
    else {
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
      if (initObj.hasOwnProperty('w')) {
        this.w = initObj.w
      }
      else {
        this.w = 0.0;
      }
      if (initObj.hasOwnProperty('perc')) {
        this.perc = initObj.perc
      }
      else {
        this.perc = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type particle_struct
    // Serialize message field [x]
    bufferOffset = _serializer.float32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float32(obj.y, buffer, bufferOffset);
    // Serialize message field [h]
    bufferOffset = _serializer.float32(obj.h, buffer, bufferOffset);
    // Serialize message field [w]
    bufferOffset = _serializer.float32(obj.w, buffer, bufferOffset);
    // Serialize message field [perc]
    bufferOffset = _serializer.float32(obj.perc, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type particle_struct
    let len;
    let data = new particle_struct(null);
    // Deserialize message field [x]
    data.x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [h]
    data.h = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [w]
    data.w = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [perc]
    data.perc = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'localization/particle_struct';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7957cf923ed20693df23fe88eee6d2e7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 x
    float32 y
    float32 h
    float32 w
    float32 perc
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new particle_struct(null);
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

    if (msg.w !== undefined) {
      resolved.w = msg.w;
    }
    else {
      resolved.w = 0.0
    }

    if (msg.perc !== undefined) {
      resolved.perc = msg.perc;
    }
    else {
      resolved.perc = 0.0
    }

    return resolved;
    }
};

module.exports = particle_struct;
