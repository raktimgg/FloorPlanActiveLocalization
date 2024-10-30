;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::topParticle)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'topParticle (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::TOPPARTICLE")
  (make-package "SEM_CLOUD::TOPPARTICLE"))

(in-package "ROS")
;;//! \htmlinclude topParticle.msg.html


(defclass sem_cloud::topParticle
  :super ros::object
  :slots (_doors _walls _x _y _h _time ))

(defmethod sem_cloud::topParticle
  (:init
   (&key
    ((:doors __doors) 0)
    ((:walls __walls) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:h __h) 0.0)
    ((:time __time) 0.0)
    )
   (send-super :init)
   (setq _doors (round __doors))
   (setq _walls (round __walls))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _h (float __h))
   (setq _time (float __time))
   self)
  (:doors
   (&optional __doors)
   (if __doors (setq _doors __doors)) _doors)
  (:walls
   (&optional __walls)
   (if __walls (setq _walls __walls)) _walls)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:h
   (&optional __h)
   (if __h (setq _h __h)) _h)
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:serialization-length
   ()
   (+
    ;; uint32 _doors
    4
    ;; uint32 _walls
    4
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _h
    4
    ;; float32 _time
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _doors
       (write-long _doors s)
     ;; uint32 _walls
       (write-long _walls s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _h
       (sys::poke _h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _time
       (sys::poke _time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _doors
     (setq _doors (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _walls
     (setq _walls (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _h
     (setq _h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _time
     (setq _time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get sem_cloud::topParticle :md5sum-) "458584feb3127cec71be9da0019fd243")
(setf (get sem_cloud::topParticle :datatype-) "sem_cloud/topParticle")
(setf (get sem_cloud::topParticle :definition-)
      "uint32 doors
uint32 walls
float32 x
float32 y
float32 h
float32 time

")



(provide :sem_cloud/topParticle "458584feb3127cec71be9da0019fd243")


