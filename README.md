# TODO

1. [Template Sensors](https://www.reddit.com/r/homeassistant/comments/pftf59/ha_is_a_hammer_and_now_im_looking_for_things_to/)
Look at posts from this [guy](https://www.reddit.com/user/85kqq5cZbcxs)
2. Create [packages](https://www.home-assistant.io/docs/configuration/packages/)
3. Fix presence detection for Christine - remove device tracker galaxy s9
 
## Google Location sharing

1. Create a dummy google account (no 2FA) and share all other users with this account
2. Install locationsharinglib

~~~
source /srv/homeassistant/bin/activate
pip install locationsharinglib mapscookiegettercli
~~~

3. Create cookies file on a linux machine with GUI and chrome

~~~
maps-cookie-getter
~~~

4. Move file to `/home/.homeassistant/setup` and test

~~~
python location.py
~~~

5. Move file to `/home/.homeassistant` if working

6. Restart Home assistant

[Example](https://github.com/dennyreiter/hass-gmaps)

## Raspberry Pi Camera stream

1. Add `v4l2` module to kernel. Add `bcm2835-v4l2` to `/etc/modules-load.d/modules.conf`

2. Install stuff

~~~
sudo apt-get install gstreamer1.0-tools gstream1.0-plugins-base gstreamer1.0-plugins-good gstream1.0-plugins-bad ffmpeg
~~~

3. Create Systemd service at `/etc/systemd/system/raspicam.service`

4. Restart raspi

~~~
sudo systemctl daemon-reload
sudo systemctl enable raspicam.service
sudo systemctl start raspicam.service
~~~

Capture image using ffmpeg

~~~
ffmpeg -f v4l2 -i /dev/video0 -vframes 1 image.jpeg
~~~

## MotionEye docker

~~~
docker run --name="motioneye" -p8765:8765 -p 8081:8081 --hostname="motioneye" -v /etc/localtime:/etc/localtime:ro -v /etc/motioneye:/etc/motioneye -v /media/usb/motioneye:/var/lib/motioneye --restart="always" --detach=true --device=/dev/video0 ccrisan/motioneye:master-armhf
~~~

Motion notification: `sleep 30s && curl -d "" https://wolverines.duckdns.org:8123/api/webhook/motion_detected?file=%Y%m%dT%H%M%S`

## [HomeAssistant Docker](https://www.home-assistant.io/docs/installation/docker/)

### Docker install on Rpi

~~~
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi
docker run hello-world
sudo apt-get install -y libffi-dev libssl-dev
sudo apt-get install -y python3 python3-pip
sudo apt-get remove python-configparser
sudo pip3 -v install docker-compose
~~~

Run using compose
~~~
docker-compose -f docker/homeassistant-compose.yml up -d
~~~

~~~
docker-compose -f docker/homeassistant-compose.yml restart
~~~

## Signal

~~~
curl -X POST -H "Content-Type: application/json" 'http://127.0.0.1:8080/v1/register/<number>'
~~~

Verify

~~~
curl -X POST -H "Content-Type: application/json" 'http://127.0.0.1:8080/v1/register/<number>/verify/<verification code>'
~~~

Receive

~~~
curl -X GET -H "Content-Type: application/json" 'http://127.0.0.1:8080/v1/receive/<number>'
~~~

# References

* [SSL Certificate](https://www.home-assistant.io/docs/ecosystem/certificates/lets_encrypt/)
* [TLS GUIDE](https://community.home-assistant.io/t/installing-tls-ssl-using-lets-encrypt/196975)
* [SIgnal Homeassistant](https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/HOMEASSISTANT.md)
