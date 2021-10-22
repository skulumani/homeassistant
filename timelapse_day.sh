#!/bin/sh
# Create timelapse from the previous day

YESTERDAY=$(date -d "yesterday" +"%Y%m%d")
LAST_MONTH=$(date -d "last month" +"%Y%m")

IMAGE_DIR="/media/shankar/data/timelapse/"

# convert to video
# -r 30 - framerate of output video - compute as function of length
# get date using $(date -d "last month" +"%Y%m%d") or equivalent

# ffmpeg -r 30 -pattern_type glob -i 20211010T*.jpg -vcodec libx264 -crf 18 -pix_fmt yuv420p timelapse.mp4
# libx265 - seems to fail for signal attachments
ffmpeg -r 30 -pattern_type glob -i "${IMAGE_DIR}${YESTERDAY}*_FRONT.jpg" -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${IMAGE_DIR}${YESTERDAY}_FRONT.mp4
ffmpeg -r 30 -pattern_type glob -i "${IMAGE_DIR}${YESTERDAY}*_BACK.jpg" -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${IMAGE_DIR}${YESTERDAY}_BACK.mp4

# delete images used 
# rm "${IMAGE_DIR}${YESTERDAY}*.jpg"
find ${IMAGE_DIR} -maxdepth 1 -type f -name "${YESTERDAY}*.jpg" -exec rm {} +
