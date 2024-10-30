;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::nodes)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'nodes (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::NODES")
  (make-package "SEM_CLOUD::NODES"))

(in-package "ROS")
;;//! \htmlinclude nodes.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass sem_cloud::nodes
  :super ros::object
  :slots (_posesId _poses ))

(defmethod sem_cloud::nodes
  (:init
   (&key
    ((:posesId __posesId) (make-array 0 :initial-element 0 :element-type :integer))
    ((:poses __poses) ())
    )
   (send-super :init)
   (setq _posesId __posesId)
   (setq _poses __poses)
   self)
  (:posesId
   (&optional __posesId)
   (if __posesId (setq _posesId __posesId)) _posesId)
  (:poses
   (&rest __poses)
   (if (keywordp (car __poses))
       (send* _poses __poses)
     (progn
       (if __poses (setq _poses (car __poses)))
       _poses)))
  (:serialization-length
   ()
   (+
    ;; int32[] _posesId
    (* 4    (length _posesId)) 4
    ;; geometry_msgs/Pose[] _poses
    (apply #'+ (send-all _poses :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _posesId
     (write-long (length _posesId) s)
     (dotimes (i (length _posesId))
       (write-long (elt _posesId i) s)
       )
     ;; geometry_msgs/Pose[] _poses
     (write-long (length _poses) s)
     (dolist (elem _poses)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _posesId
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _posesId (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _posesId i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; geometry_msgs/Pose[] _poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get sem_cloud::nodes :md5sum-) "0aa0e2793de02d3b5e7aa2ce56d2f367")
(setf (get sem_cloud::nodes :datatype-) "sem_cloud/nodes")
(setf (get sem_cloud::nodes :definition-)
      "int32[] posesId
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

")



(provide :sem_cloud/nodes "0aa0e2793de02d3b5e7aa2ce56d2f367")


