#!/bin/bash

sudo apt-get install ffmpeg libmariadb3 libpq5 libmicrohttpd12

wget https://github.com/Motion-Project/motion/releases/download/release-4.2.2/pi_buster_motion_4.2.2-1_armhf.deb
dpkg -i pi_buster_motion_4.2.2-1_armhf.deb


