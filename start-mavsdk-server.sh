#!/bin/bash
echo "Starting mavsdk server on port 50051, listening for"
mavsdk_server -p 50051 udp://:14551 &
