cmake_minimum_required(VERSION 3.0.2)
project(localization_navigation)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  actionlib
  move_base_msgs
  roscpp
  sensor_msgs
  message_filters
  cv_bridge
  pcl_conversions
  pcl_msgs
)

## Find PCL package
find_package(PCL REQUIRED QUIET COMPONENTS common io kdtree search surface filters registration sample_consensus segmentation visualization)

## Uncomment this if the package has a setup.py
# catkin_python_setup()

###################################
## catkin specific configuration ##
###################################
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES localization_navigation
#  CATKIN_DEPENDS actionlib move_base_msgs roscpp
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}/include/localization_navigation
)

## Declare C++ executables and link libraries
add_executable(goal_client src/targetClient.cpp)
target_link_libraries(goal_client ${catkin_LIBRARIES})

add_executable(commands src/voiceCommands.cpp)
target_link_libraries(commands ${catkin_LIBRARIES})

add_executable(cloud src/currentCloud.cpp)
target_link_libraries(cloud ${catkin_LIBRARIES} ${PCL_LIBRARIES})

#############
## Install ##
#############
install(FILES
  launch/path_planner.launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

## Uncomment to mark executables for installation
# install(TARGETS goal_client commands cloud
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Uncomment to mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

#############
## Testing ##
#############

## Uncomment to add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_localization_navigation.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Uncomment to add folders to be run by python nosetests
# catkin_add_nosetests(test)
