; Auto-generated. Do not edit!


(cl:in-package sem_cloud-msg)


;//! \htmlinclude particle_struct.msg.html

(cl:defclass <particle_struct> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (h
    :reader h
    :initarg :h
    :type cl:float
    :initform 0.0)
   (w
    :reader w
    :initarg :w
    :type cl:float
    :initform 0.0)
   (perc
    :reader perc
    :initarg :perc
    :type cl:float
    :initform 0.0))
)

(cl:defclass particle_struct (<particle_struct>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <particle_struct>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'particle_struct)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sem_cloud-msg:<particle_struct> is deprecated: use sem_cloud-msg:particle_struct instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <particle_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:x-val is deprecated.  Use sem_cloud-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <particle_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:y-val is deprecated.  Use sem_cloud-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'h-val :lambda-list '(m))
(cl:defmethod h-val ((m <particle_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:h-val is deprecated.  Use sem_cloud-msg:h instead.")
  (h m))

(cl:ensure-generic-function 'w-val :lambda-list '(m))
(cl:defmethod w-val ((m <particle_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:w-val is deprecated.  Use sem_cloud-msg:w instead.")
  (w m))

(cl:ensure-generic-function 'perc-val :lambda-list '(m))
(cl:defmethod perc-val ((m <particle_struct>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sem_cloud-msg:perc-val is deprecated.  Use sem_cloud-msg:perc instead.")
  (perc m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <particle_struct>) ostream)
  "Serializes a message object of type '<particle_struct>"
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'h))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'w))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'perc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <particle_struct>) istream)
  "Deserializes a message object of type '<particle_struct>"
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
    (cl:setf (cl:slot-value msg 'h) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'w) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'perc) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<particle_struct>)))
  "Returns string type for a message object of type '<particle_struct>"
  "sem_cloud/particle_struct")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'particle_struct)))
  "Returns string type for a message object of type 'particle_struct"
  "sem_cloud/particle_struct")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<particle_struct>)))
  "Returns md5sum for a message object of type '<particle_struct>"
  "7957cf923ed20693df23fe88eee6d2e7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'particle_struct)))
  "Returns md5sum for a message object of type 'particle_struct"
  "7957cf923ed20693df23fe88eee6d2e7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<particle_struct>)))
  "Returns full string definition for message of type '<particle_struct>"
  (cl:format cl:nil "float32 x~%float32 y~%float32 h~%float32 w~%float32 perc~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'particle_struct)))
  "Returns full string definition for message of type 'particle_struct"
  (cl:format cl:nil "float32 x~%float32 y~%float32 h~%float32 w~%float32 perc~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <particle_struct>))
  (cl:+ 0
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <particle_struct>))
  "Converts a ROS message object to a list"
  (cl:list 'particle_struct
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':h (h msg))
    (cl:cons ':w (w msg))
    (cl:cons ':perc (perc msg))
))
