## Installation

~~~
sudo apt-get install cerbot ssl-cert-check libxslt1.1 
sudo apt-get install -y python-dev pkg-config libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev
~~~

## Autostart

~~~
cp /home/homeassistant/.homeassistant/setup/home-asssitant@homeassistant.service /etc/systemd/system
sudo systemctl --system daemon-reload
sudo systemctl enable home-assistant@homeassistant
sudo systemctl start home-assistant@homeassistant.service
~~~

## Start/Stop 

Replace restart with start/stop

~~~
sudo systemctl restart home-assistant@homeassistant.service
sudo journalctl -f -u home-assistant@homeassistant
~~~

## Updating python and updating the virtual environment
0. Stop homeassistant

~~~
sudo systemctl stop home-assistant@homeassistant.service
ps -ef | grep home
~~~

1. Update python using `update_python.sh`

2. Reactivate the virutal enviornment for homeassistant

~~~
source /srv/homeassistant/bin/activate
~~~

3. Freeze the current python dependencies

~~~
pip3 freeze -local > requirements.txt
~~~

4. Deactivate the environment

~~~
deactivate
~~~

5. Use new python version to create another enviornment

~~~
cd /srv
sudo mkdir homeassistant
sudo chown homeassistant:homeassistant homeassistant
sudo -u homeassistant -H -s
python3.7 -m venv .
source /srv/homeassistant/bin/activate
~~~

6. Check that is worked correctly

~~~
python --version
python3 --version
pip3 --version
~~~

7. Go to homeassistant directory and update requirements

Still in python env!

~~~
pip3 install -r requirements.txt
~~~

8. Update systemd if needed `/etc/systemd/systems/home-assistant@homeassistant.service`

9. Restart and check if running

~~~
sudo systemctl daemon-reload
sudo systemctl start home-assistant@homeassistant.service
ps -ef | grep home
~~~

Check to make sure correct version of Python is running hass

Some useful links

* https://community.home-assistant.io/t/python-3-6-upgrade-of-a-virtualenv/21722
* https://raspberrypi.stackexchange.com/questions/59381/how-do-i-update-my-rpi3-to-python-3-6
* https://stackoverflow.com/questions/37079195/how-do-you-update-to-the-latest-python-3-5-1-version-on-a-raspberry-pi

## Update homeassistant

~~~
sudo systemctl stop home-assistant@homeassistant.service
sudo -u homeassistant -H -s
source /srv/homeassistant/bin/activate
pip3 install --upgrade homeassistant
exit
sudo systemctl start home-assistant@homeassistant.service
~~~

* [Common tasks](https://www.home-assistant.io/docs/installation/hassbian/common-tasks/)

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
curl -X POST -H "Content-Type: application/json" 'http://<ip>:<port>/v1/register/<number>'
~~~

Verify

~~~
curl -X POST -H "Content-Type: application/json" 'http://<ip>:<port>/v1/register/<number>/verify/<verification code>'
~~~

# References

* [SSL Certificate](https://www.home-assistant.io/docs/ecosystem/certificates/lets_encrypt/)
* [TLS GUIDE](https://community.home-assistant.io/t/installing-tls-ssl-using-lets-encrypt/196975)
* [SIgnal Homeassistant](https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/HOMEASSISTANT.md)
