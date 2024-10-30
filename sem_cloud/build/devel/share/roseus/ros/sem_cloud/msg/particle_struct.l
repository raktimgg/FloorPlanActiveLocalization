;; Auto-generated. Do not edit!


(when (boundp 'sem_cloud::particle_struct)
  (if (not (find-package "SEM_CLOUD"))
    (make-package "SEM_CLOUD"))
  (shadow 'particle_struct (find-package "SEM_CLOUD")))
(unless (find-package "SEM_CLOUD::PARTICLE_STRUCT")
  (make-package "SEM_CLOUD::PARTICLE_STRUCT"))

(in-package "ROS")
;;//! \htmlinclude particle_struct.msg.html


(defclass sem_cloud::particle_struct
  :super ros::object
  :slots (_x _y _h _w _perc ))

(defmethod sem_cloud::particle_struct
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:h __h) 0.0)
    ((:w __w) 0.0)
    ((:perc __perc) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _h (float __h))
   (setq _w (float __w))
   (setq _perc (float __perc))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:h
   (&optional __h)
   (if __h (setq _h __h)) _h)
  (:w
   (&optional __w)
   (if __w (setq _w __w)) _w)
  (:perc
   (&optional __perc)
   (if __perc (setq _perc __perc)) _perc)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _h
    4
    ;; float32 _w
    4
    ;; float32 _perc
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _h
       (sys::poke _h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _w
       (sys::poke _w (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _perc
       (sys::poke _perc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _h
     (setq _h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _w
     (setq _w (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _perc
     (setq _perc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get sem_cloud::particle_struct :md5sum-) "7957cf923ed20693df23fe88eee6d2e7")
(setf (get sem_cloud::particle_struct :datatype-) "sem_cloud/particle_struct")
(setf (get sem_cloud::particle_struct :definition-)
      "float32 x
float32 y
float32 h
float32 w
float32 perc

")



(provide :sem_cloud/particle_struct "7957cf923ed20693df23fe88eee6d2e7")


