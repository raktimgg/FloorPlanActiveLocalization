<!-- Run the following command to compile the workspace:

catkin build --cmake-args -DWITH_TORCH=ON -DCMAKE_PREFIX_PATH="/opt/ros/noetic" -Drtabmap_ros_DIR="/home/crrl/floorplan_nav_ws/devel/.private/rtabmap_ros/share/rtabmap_ros/cmake"

Key: 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 -->

# Floor Plan Based Active Global Localization and Navigation Aid for Persons with Blindness and Low Vision

This project presents a real-time system for active global localization and navigation, specifically designed to assist individuals with blindness and low vision in navigating unfamiliar environments. The system uses architectural floor plans and a stereo-inertial camera to generate semantically informed goals for exploration, effectively localizing the user and correcting for odometry drift. This work enhances accessibility and is adaptable for mobile robots, validated through extensive real-world indoor experiments.

📖 Paper: [`RA-L`](https://ieeexplore.ieee.org/document/10734166)

📹 Video: [`Youtube`](https://www.youtube.com/watch?v=DEyLDDNrEqw)

__Contributors:__ [Raktim Gautam Goswami<sup>1</sup>](https://raktimgg.github.io/my-website)
, [Harshit Sinha<sup>1</sup>](https://www.linkedin.com/in/harshitsinha08)
, [Venkata Amith Palacherla<sup>1</sup>](https://github.com/venkataPalacherla)
, [Jagennath Hari<sup>1</sup>](https://github.com/jagennath-hari)
, [Prashanth Krishnamurthy<sup>1</sup>](https://scholar.google.com/citations?user=W-_zgGgAAAAJ)
, [JohnRoss Rizzo<sup>2</sup>](https://med.nyu.edu/faculty/johnross-rizzo)
, [Farshad Khorrami<sup>1</sup>](https://scholar.google.com/citations?user=NdOqlPQAAAAJ&hl=en)

We would like to thank [Tanishq Bhansali<sup>1</sup>](https://www.linkedin.com/in/tanishq-bhansali) for his help in conducting the experiments.

#### <sup>1</sup>Control/Robotics Research Laboratory (CRRL), Department of Electrical and Computer Engineering, NYU Tandon School of Engineering

#### <sup>2</sup>Rusk Institute of Rehabilitation, New York University Grossman School of Medicine

### 💡 Contributions
- **Active Global Localization**: Developed a real-time global localization system that leverages architectural floor plans, enabling navigation aid for individuals with blindness and low vision.
- **Odometry Drift Correction**: Implemented a method to correct time-varying drift in odometry, ensuring accurate localization over extended periods.
- **Loop Closure on Reversal**: Added loop closure functionality for handling path reversals, which improves localization stability in dynamic indoor environments.
- **2D Semantic Point Cloud Generation**: Created a 2D semantic point cloud for enhanced real-time agent tracking and navigation, integrating semantic mapping with floor plan data.
- **HRNet Integration**: Incorporated the HRNet model for robust semantic segmentation, improving the system’s perception and navigation accuracy.


## Table of Contents

- [Installations](#1-installations)
  - [RTAB-MAP Installation](#11-rtab-map-installation)
  - [ROS Installation](#12-ros-installation)
  - [Dependencies](#13-dependencies)
  - [Changing the Semantic Segmentation Model in RTAB-Map](#14-changing-the-semantic-segmentation-model-in-rtab-map)
- [Usage](#2-usage)
- [Features](#3-features)

## 1. Installations

This package has been deployed on an __NVIDIA Jetson Orin__ device, operating with __JetPack version 5.2__ on __Ubuntu 20.04__. It has been installed within the __ROS1__ workspace.

### 1.1 RTAB-MAP 

RTAB-MAP version __0.20.23__ should be installed outside the ROS workspace. <br>
For detailed instructions on the installation and configuration of RTAB-MAP, please refer to the official installation guidelines available on [RTAB-MAP GitHub](https://github.com/introlab/rtabmap).

### 1.2 ROS Installation

This package is designed to operate within ROS Noetic. For instructions on setting up and configuring a ROS workspace, please refer to the [ROS installation guide](http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment).

### 1.3 Dependencies

- **depthimage_to_laserscan**: This package depends on `depthimage_to_laserscan`, which should be installed in the ROS workspace.
- **OpenCV 4.6**: OpenCV version 4.6 is required for both this package and RTAB-MAP standalone. To manage OpenCV dependencies within ROS, `vision_opencv` can be utilized, ensuring compatibility and maintaining the required OpenCV version.

### 1.4 Changing the Semantic Segmentation Model in RTAB-Map

This package uses the **HRNet** model for semantic segmentation, as described in:

> J. Wang, K. Sun, T. Cheng, B. Jiang, C. Deng, Y. Zhao, D. Liu, Y. Mu, M. Tan, X. Wang, et al., “Deep high-resolution representation learning for visual recognition,” *IEEE Transactions on Pattern Analysis and Machine Intelligence*, vol. 43, pp. 3349–3364, 2020.

To change the semantic segmentation model in RTAB-Map, follow these steps:

1. Navigate to the RTAB-Map core library source directory:
```bash
cd ~/libraries/rtabmap/corelib/src/
```
2. Open `memory.cpp` and modify the model path at line 137.

3. Build and install RTAB-MAP
```bash
cd ~/libraries/rtabmap/build
cmake ..
make
sudo make install
```

4. Rebuild RTAB-MAP in the ROS workspace:
```bash
cd ~/your_ros_workspace
catkin build --cmake-args -DWITH_TORCH=ON -DCMAKE_BUILD_TYPE=Release
```

## 2. Usage

1. Navigate to the src folder of your ROS WORKSPACE.
2. Clone this repository to the source folder. (remeber to but a period at the end)
```bash
git clone https://github.com/Harshit0803/fp_files.git . 
```
3. Once cloned, it should look like this
```
ROS_WORKSPACE_PATH/
    build/
    devel/
    src/
      localization/
      localization_navigation/
      sem_cloud/
      README.md
```
4. Building the workspace
```bash
cd ..
catkin build --cmake-args -DWITH_TORCH=ON -DCMAKE_BUILD_TYPE=Release \
-Drtabmap_ros_DIR="/home/username/your_workspace/devel/.private/rtabmap_ros/share/rtabmap_ros/cmake"
```
