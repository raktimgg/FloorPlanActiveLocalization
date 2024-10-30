cmake_minimum_required(VERSION 3.0.2)
project(localization)

find_package(catkin REQUIRED COMPONENTS
  message_filters
  pcl_ros
  roscpp
  geometry_msgs
  rospy
  rtabmap_ros
  sensor_msgs
  std_msgs
  message_generation
  tf
  nav_msgs
  visualization_msgs
  move_base_msgs
)

add_message_files(
  FILES
  topParticle.msg
  coordinate.msg
  landmark_msg.msg
  particle_struct.msg
  particle_msg.msg
  robot_struct.msg
  robot_msg.msg
)

generate_messages(DEPENDENCIES std_msgs)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES localization
  CATKIN_DEPENDS message_filters pcl_ros roscpp rospy rtabmap_ros sensor_msgs std_msgs message_runtime
  DEPENDS system_lib
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}/include/localization
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CATKIN_DEVEL_PREFIX}/include
  ${CMAKE_BINARY_DIR}/devel/include
  ${CMAKE_CURRENT_SOURCE_DIR}/build/devel/include
)

add_executable(slam2_decoupled src/CPP/slam2_decoupled.cpp)
target_link_libraries(slam2_decoupled ${catkin_LIBRARIES})

add_executable(marker src/CPP/markerViz.cpp)
target_link_libraries(marker ${catkin_LIBRARIES})

catkin_install_python(PROGRAMS
  scripts/notification_python.py
  src/python/plotting.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
