# syntax=docker/dockerfile:1
# Start the image with the ros:melodic base image
FROM ros:melodic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
apt-utils \
wget \
git \
ros-melodic-tf \
ros-melodic-pcl-conversions \
libpcl-dev \
python3-catkin-tools \
bash-completion \
build-essential \
sudo \
curl \
python3-rosdep \
python3-rosinstall-generator \
python3-matplotlib \
python3-tk \
python3-vcstool \
build-essential \
ros-melodic-rqt \
ros-melodic-rqt-common-plugins \
# clear apt cache
&& rm -rf /var/lib/apt/lists/*

# Clean image
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* 

# Create a catkin_ws directory for removert
RUN mkdir -p /catkin_ws/src/removert
RUN cd /catkin_ws/src

# Copy the removert source code into the /catin_ws/src/removert directory
#COPY . /catkin_ws/src/removert

# Source (does this work? It does not work when typed into terminal, both sh & bash)
#RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash' 
# !!! has to be typed into every shell

# setup entrypoint
COPY ./ros_entrypoint.sh /catkin_ws
RUN chmod +x /catkin_ws/ros_entrypoint.sh
ENTRYPOINT ./catkin_ws/ros_entrypoint.sh

# register source for rosdep
#RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt-get update
RUN rosdep update


