#!/bin/sh
# record_lq.sh
# Record ip cam in segments

STARTTIME=$(date +"%Y%m%dT%H%M")

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
IMAGE_DIR="/home/shankar/Documents/timelapse/"
if [[ ! -e ${IMAGE_DIR} ]]; then
    mkdir -p ${IMAGE_DIR}
fi

# ffmpeg -i "rtmp://192.168.88.12:1935/live/front" -r 1 -t 1 ${STARTTIME}.jpg
# ffmpeg -i "rtmp://192.168.88.12:1935/live/back" -r 1 -t 1 ${STARTTIME}.jpg

ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}/bcs/channel0_main.bcs?token=ssdad&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -t 1 -r 1 ${IMAGE_DIR}${FRONT_CAM}.jpg &
ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}/bcs/channel0_main.bcs?token=sdasdasd&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -t 1 -r 1 ${IMAGE_DIR}${BACK_CAM}.jpg &


# convert to video
# -r 30 - framerate of output video - compute as function of length
# get date using $(date -d "last month" +"%Y%m%d") or equivalent

# ffmpeg -r 30 -pattern_type glob -i 20211010T*.jpg -vcodec libx264 -crf 18 -pix_fmt yuv420p timelapse.mp4
