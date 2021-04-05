#!/bin/bash
# record_hq.sh
# Record ip cam in segments

# This will print the current date and time in a format appropriate for storage
STARTTIME=$(date +"%Y%m%dT%H%M%S")

## IP Camera Names ##
# Creating date stamps for each of the five cameras
FRONT_CAM="${STARTTIME}_FRONT"
BACK_CAM="${STARTTIME}_BACK"

CAM_USERNAME="stream"
CAM_PASSWORD="dgdiPUdFwqkqBwRFSq"

FRONT_IP="192.168.200.15"
BACK_IP="192.168.200.16"
## Network and Local Storage Locations  ##
HQDIR="/media/shankar/usbdrive/video/high/" #Trailing '/' is necessary here
LQDIR="/media/shankar/usbdrive/video/low/"

## Record Time per File ##
HQLENGTH="900" # (Runtime expressed in seconds)

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcodec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
# ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}:554/h264Preview_01_main" -vcodec copy -acodec copy -t ${HQLENGTH} ${HQDIR}${FRONT_CAM}.mp4 &
# ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}:554/h264Preview_01_main" -vcodec copy -acodec copy -t ${HQLENGTH} ${HQDIR}${BACK_CAM}.mp4 &

# rtmp://stream:dgdiPUdFwqkqBwRFSq@192.168.200.15/bcs/channel0_sub.bcs?token=sdasdasd&channel=0&stream=0&user=stream&password=dgdiPUdFwqkqBwRFSq

ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}/bcs/channel0_main.bcs?token=ssdad&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -vcodec copy -acodec copy -t ${HQLENGTH} ${HQDIR}${FRONT_CAM}.mp4 &
ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}/bcs/channel0_main.bcs?token=sdasdasd&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -vcodec copy -acodec copy -t ${HQLENGTH} ${HQDIR}${BACK_CAM}.mp4 &
