; Auto-generated. Do not edit!


(cl:in-package localization-msg)


;//! \htmlinclude topParticle.msg.html

(cl:defclass <topParticle> (roslisp-msg-protocol:ros-message)
  ((doors
    :reader doors
    :initarg :doors
    :type cl:integer
    :initform 0)
   (walls
    :reader walls
    :initarg :walls
    :type cl:integer
    :initform 0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (heading
    :reader heading
    :initarg :heading
    :type cl:float
    :initform 0.0)
   (time
    :reader time
    :initarg :time
    :type cl:float
    :initform 0.0))
)

(cl:defclass topParticle (<topParticle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <topParticle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'topParticle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization-msg:<topParticle> is deprecated: use localization-msg:topParticle instead.")))

(cl:ensure-generic-function 'doors-val :lambda-list '(m))
(cl:defmethod doors-val ((m <topParticle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:doors-val is deprecated.  Use localization-msg:doors instead.")
  (doors m))

(cl:ensure-generic-function 'walls-val :lambda-list '(m))
(cl:defmethod walls-val ((m <topParticle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:walls-val is deprecated.  Use localization-msg:walls instead.")
  (walls m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <topParticle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:x-val is deprecated.  Use localization-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <topParticle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:y-val is deprecated.  Use localization-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'heading-val :lambda-list '(m))
(cl:defmethod heading-val ((m <topParticle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:heading-val is deprecated.  Use localization-msg:heading instead.")
  (heading m))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <topParticle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization-msg:time-val is deprecated.  Use localization-msg:time instead.")
  (time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <topParticle>) ostream)
  "Serializes a message object of type '<topParticle>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'doors)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'doors)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'doors)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'doors)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'walls)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'walls)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'walls)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'walls)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'heading))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <topParticle>) istream)
  "Deserializes a message object of type '<topParticle>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'doors)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'doors)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'doors)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'doors)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'walls)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'walls)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'walls)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'walls)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heading) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<topParticle>)))
  "Returns string type for a message object of type '<topParticle>"
  "localization/topParticle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'topParticle)))
  "Returns string type for a message object of type 'topParticle"
  "localization/topParticle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<topParticle>)))
  "Returns md5sum for a message object of type '<topParticle>"
  "155251b74991e5f56febfbb210555676")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'topParticle)))
  "Returns md5sum for a message object of type 'topParticle"
  "155251b74991e5f56febfbb210555676")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<topParticle>)))
  "Returns full string definition for message of type '<topParticle>"
  (cl:format cl:nil "uint32 doors~%uint32 walls~%float32 x~%float32 y~%float32 heading~%float32 time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'topParticle)))
  "Returns full string definition for message of type 'topParticle"
  (cl:format cl:nil "uint32 doors~%uint32 walls~%float32 x~%float32 y~%float32 heading~%float32 time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <topParticle>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <topParticle>))
  "Converts a ROS message object to a list"
  (cl:list 'topParticle
    (cl:cons ':doors (doors msg))
    (cl:cons ':walls (walls msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':heading (heading msg))
    (cl:cons ':time (time msg))
))
