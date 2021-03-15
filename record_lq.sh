#!/bin/sh
# record_lq.sh
# Record ip cam in segments

STARTTIME=$(date +"%Y%m%dT%H%M%S")

## IP Camera Names ##
FRONT_CAM="${STARTTIME}_FRONT"
BACK_CAM="${STARTTIME}_BACK"

CAM_USERNAME="stream"
CAM_PASSWORD="dgdiPUdFwqkqBwRFSq"

FRONT_IP="192.168.200.15"
BACK_IP="192.168.200.16"

## Network and Local Storage Locations  ##
# Pay attending to when a trailing '/' is used and when it is not
## Network and Local Storage Locations  ##
HQDIR="/media/shankar/usbdrive/video/high/" #Trailing '/' is necessary here
LQDIR="/media/shankar/usbdrive/video/low/"

## Record Time per File ##
LQLENGTH="3600" # (Runtime expressed in seconds)

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcidec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}:554/h264Preview_01_sub" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${FRONT_CAM}.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}:554/h264Preview_01_sub" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${BACK_CAM}.mp4 &

        # - path: rtmp://{FRIGATE_CAM_USERNAME}:{FRIGATE_CAM_PASSWORD}@{FRIGATE_FRONT_CAM_IP}/bcs/channel0_main.bcs?token=sdasdasd&channel=0&stream=0&user={FRIGATE_CAM_USERNAME}&password={FRIGATE_CAM_PASSWORD}
        # - path: rtmp://{FRIGATE_CAM_USERNAME}:{FRIGATE_CAM_PASSWORD}@{FRIGATE_FRONT_CAM_IP}/bcs/channel0_sub.bcs?token=sdasdasd&channel=0&stream=0&user={FRIGATE_CAM_USERNAME}&password={FRIGATE_CAM_PASSWORD}
