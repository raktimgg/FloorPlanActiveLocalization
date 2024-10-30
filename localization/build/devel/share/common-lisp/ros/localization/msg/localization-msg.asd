
(cl:in-package :asdf)

(defsystem "localization-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "coordinate" :depends-on ("_package_coordinate"))
    (:file "_package_coordinate" :depends-on ("_package"))
    (:file "landmark_msg" :depends-on ("_package_landmark_msg"))
    (:file "_package_landmark_msg" :depends-on ("_package"))
    (:file "particle_msg" :depends-on ("_package_particle_msg"))
    (:file "_package_particle_msg" :depends-on ("_package"))
    (:file "particle_struct" :depends-on ("_package_particle_struct"))
    (:file "_package_particle_struct" :depends-on ("_package"))
    (:file "robot_msg" :depends-on ("_package_robot_msg"))
    (:file "_package_robot_msg" :depends-on ("_package"))
    (:file "robot_struct" :depends-on ("_package_robot_struct"))
    (:file "_package_robot_struct" :depends-on ("_package"))
    (:file "topParticle" :depends-on ("_package_topParticle"))
    (:file "_package_topParticle" :depends-on ("_package"))
  ))