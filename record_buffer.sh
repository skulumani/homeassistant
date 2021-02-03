#!/bin/bash
# record_hq.sh
# Record ip cam in segments

# BUFFER RECORDING - https://github.com/MAPReiff/ShadowRePlay-Linux
# https://superuser.com/questions/1544521/how-to-setup-ffmpeg-for-the-same-record-method-which-is-used-in-obs-studio-repl

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

REPLAY_BUFFER="6"
BUFFER_SEC="30"
BUFFER_SEGMENT_LENGTH="5"
BUFFER_SEGMENTS=$((BUFFER_SEC / BUFFER_SEGMENT_LENGTH))

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcidec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
# ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}:554/h264Preview_01_main" -vcodec copy -acodec copy -t ${HQLENGTH} ${HQDIR}${FRONT_CAM}.mp4 &
# ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}:554/h264Preview_01_main" -vcodec copy -acodec copy -t ${HQLENGTH} ${HQDIR}${BACK_CAM}.mp4 &

# This is recording video to a buffer
ffmpeg -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}:554/h264Preview_01_main" -vcodec copy -acodec copy -f segment -segment_time "${BUFFER_SEGMENT_LENGTH}" -segment_wrap "${BUFFER_SEGMENTS}" -segment_list list.m3u8 -segment_list_size "${BUFFER_SEGMENTS}" seg%d.ts

# when motion detected need to kill ffmpeg and run following
ffmpeg -i list.m3u8 -c copy output_video.mp4


