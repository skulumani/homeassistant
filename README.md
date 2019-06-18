## Start/Stop 

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
