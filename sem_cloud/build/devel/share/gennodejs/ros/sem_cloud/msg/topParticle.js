// Auto-generated. Do not edit!

// (in-package sem_cloud.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class topParticle {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.doors = null;
      this.walls = null;
      this.x = null;
      this.y = null;
      this.h = null;
      this.time = null;
    }
    else {
      if (initObj.hasOwnProperty('doors')) {
        this.doors = initObj.doors
      }
      else {
        this.doors = 0;
      }
      if (initObj.hasOwnProperty('walls')) {
        this.walls = initObj.walls
      }
      else {
        this.walls = 0;
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
      if (initObj.hasOwnProperty('time')) {
        this.time = initObj.time
      }
      else {
        this.time = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type topParticle
    // Serialize message field [doors]
    bufferOffset = _serializer.uint32(obj.doors, buffer, bufferOffset);
    // Serialize message field [walls]
    bufferOffset = _serializer.uint32(obj.walls, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float32(obj.y, buffer, bufferOffset);
    // Serialize message field [h]
    bufferOffset = _serializer.float32(obj.h, buffer, bufferOffset);
    // Serialize message field [time]
    bufferOffset = _serializer.float32(obj.time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type topParticle
    let len;
    let data = new topParticle(null);
    // Deserialize message field [doors]
    data.doors = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [walls]
    data.walls = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [h]
    data.h = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [time]
    data.time = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sem_cloud/topParticle';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '458584feb3127cec71be9da0019fd243';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 doors
    uint32 walls
    float32 x
    float32 y
    float32 h
    float32 time
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new topParticle(null);
    if (msg.doors !== undefined) {
      resolved.doors = msg.doors;
    }
    else {
      resolved.doors = 0
    }

    if (msg.walls !== undefined) {
      resolved.walls = msg.walls;
    }
    else {
      resolved.walls = 0
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

    if (msg.time !== undefined) {
      resolved.time = msg.time;
    }
    else {
      resolved.time = 0.0
    }

    return resolved;
    }
};

module.exports = topParticle;
