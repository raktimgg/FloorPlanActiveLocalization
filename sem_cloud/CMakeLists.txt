cmake_minimum_required(VERSION 3.0.2)
project(sem_cloud)

# Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  cv_bridge
  image_transport
  roscpp
  pcl_ros
  rospy
  sensor_msgs
  std_msgs
  message_generation
  geometry_msgs
  genmsg
  message_filters
  tf
)

# Add custom CMake prefix path for Torch
list(APPEND CMAKE_PREFIX_PATH "/home/crrl/libraries/pytorch-install/share/cmake/Torch")
find_package(Torch REQUIRED)
find_package(PCL REQUIRED COMPONENT common io visualization filters conversions)
find_package(OpenCV REQUIRED)

# Declare ROS messages
add_message_files(
  FILES
  Info.msg
  KeyPoint.msg
  GlobalDescriptor.msg
  ScanDescriptor.msg
  MapData.msg
  MapGraph.msg
  NodeData.msg
  Link.msg 
  OdomInfo.msg
  Point2f.msg
  Point3f.msg
  Goal.msg 
  RGBDImage.msg
  RGBDImages.msg
  UserData.msg
  GPS.msg
  Path.msg
  EnvSensor.msg
  nodes.msg
  Semantic.msg
  RGBDS.msg
  rgbdss.msg
  rds.msg 
  imagepose.msg
  topParticle.msg
  particle_msg.msg
  particle_struct.msg
  robot_struct.msg
  commandsafe.msg 
)

# Generate added messages
generate_messages(
  DEPENDENCIES
  sensor_msgs
  std_msgs
  geometry_msgs 
)

# Declare a catkin package
catkin_package(
  INCLUDE_DIRS include
  LIBRARIES sem_cloud
  CATKIN_DEPENDS cv_bridge image_transport roscpp rospy sensor_msgs std_msgs message_runtime message_filters
  DEPENDS system_lib OpenCV
)

# Include directories
include_directories(
  ${OpenCV_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  ${TORCH_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}/include/sem_cloud/sync_msg
  ${CMAKE_CURRENT_SOURCE_DIR}/include/sem_cloud
  ${CATKIN_DEVEL_PREFIX}/include
  ${CMAKE_BINARY_DIR}/devel/include
  ${CMAKE_CURRENT_SOURCE_DIR}/build/devel/include
)

# Declare executables
add_executable(sync_i src/sync_image.cpp)
add_executable(odom src/odom_correction.cpp)
add_executable(semantic_Cloud src/semanticCloud.cpp)
add_executable(explore_ZED src/exploration.cpp)
add_executable(commands_new src/voiceCommands_new.cpp)

# Specify libraries to link a library or executable target against
target_link_libraries(odom ${catkin_LIBRARIES})
target_link_libraries(sync_i ${catkin_LIBRARIES} ${TORCH_LIBRARIES} ${OpenCV_LIBRARIES})
target_link_libraries(semantic_Cloud ${catkin_LIBRARIES} ${OpenCV_LIBRARIES})
target_link_libraries(commands_new ${catkin_LIBRARIES} ${PCL_LIBRARIES})
target_link_libraries(explore_ZED ${catkin_LIBRARIES})

# Add dependencies to the commands_new target
add_dependencies(commands_new ${${PROJECT_NAME}_EXPORTED_TARGETS})

# Install Python scripts
catkin_install_python(PROGRAMS
  scripts/voice.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# Install launch files
install(FILES
  launch/localization.launch
  launch/bag.launch
  launch/error_plot.launch
  launch/semantic_SLAM.launch
  launch/superpoint_semantic_slam.launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
