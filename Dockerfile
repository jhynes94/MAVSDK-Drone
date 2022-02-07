FROM arm64v8/ubuntu:bionic

WORKDIR /home

RUN apt-get update
RUN apt-get install cmake build-essential colordiff git doxygen -y
RUN apt-get install python3 python3-pip -y
RUN apt install git -y

RUN git clone https://github.com/mavlink/MAVSDK.git

WORKDIR /home/MAVSDK
RUN git checkout master
RUN git submodule update --init --recursive

RUN cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_MAVSDK_SERVER=ON -DBUILD_SHARED_LIBS=OFF -Bbuild/default -H.
RUN cmake --build build/default --target install -- -j 4
RUN ldconfig

WORKDIR /home

RUN pip3 install mavsdk
RUN git clone https://github.com/mavlink/MAVSDK-Python.git
WORKDIR /home/MAVSDK-Python
RUN git submodule update --init --recursive

WORKDIR /home
COPY takeoff_and_land2.py .
COPY offboard_position_ned2.py .
COPY start-mavsdk-server.sh .

CMD ["/bin/bash"]
