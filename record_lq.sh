#!/bin/sh
# record_lq.sh
# Record ip cam in segments

STARTTIME=$(date +"%Y%m%dT%H%M%S")

## IP Camera Names ##
FRONT_CAM="${STARTTIME}_FRONT"
BACK_CAM="${STARTTIME}_BACK"

CAM_USERNAME="stream"
CAM_PASSWORD="dgdiPUdFwqkqBwRFSq"

FRONT_IP="192.168.88.15"
BACK_IP="192.168.88.16"

## Network and Local Storage Locations  ##
# Pay attending to when a trailing '/' is used and when it is not
## Network and Local Storage Locations  ##
HQDIR="/media/data/video/high/" #Trailing '/' is necessary here
LQDIR="/media/data/video/low/"

## Record Time per File ##
LQLENGTH="10" # (Runtime expressed in seconds)

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcidec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}:554/h264Preview_01_sub" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${FRONT_CAM}.mkv &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}:554/h264Preview_01_sub" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${BACK_CAM}.mkv &
