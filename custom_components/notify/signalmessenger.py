"""
Signal Messenger for notify component.
Place this in `homeassistant/components/notify/signalmessenger.py` 
"""
import pathlib
import subprocess
import logging
import voluptuous as vol
from homeassistant.components.notify import (
    ATTR_DATA, ATTR_TITLE, ATTR_TITLE_DEFAULT, PLATFORM_SCHEMA,
    BaseNotificationService)
from homeassistant.const import CONF_API_KEY
import homeassistant.helpers.config_validation as cv

REQUIREMENTS = []

_LOGGER = logging.getLogger("signalmessenger")

CONF_SENDER_NR = 'sender_nr'
CONF_RECP_NR = 'recp_nr'
CONF_SIGNAL_CLI_PATH = 'signal_cli_path'

PLATFORM_SCHEMA = PLATFORM_SCHEMA.extend({
    vol.Optional(CONF_SENDER_NR): cv.string,
    vol.Optional(CONF_RECP_NR): cv.string,
    vol.Optional(CONF_SIGNAL_CLI_PATH): cv.string,
})


def get_service(hass, config, discovery_info=None):
    """Get the Join notification service."""
    sender_nr = config.get(CONF_SENDER_NR)
    recp_nr = config.get(CONF_RECP_NR)
    signal_cli_path = config.get(CONF_SIGNAL_CLI_PATH)

    if sender_nr is None or recp_nr is None or signal_cli_path is None:
        _LOGGER.error("No device was provided. Please specify sender_nr"
                      ", recp_nr, or signal_cli_path")
        return False

    return SignalNotificationService(sender_nr, recp_nr, signal_cli_path)


class SignalNotificationService(BaseNotificationService):
    """Implement the notification service for Join."""

    def __init__(self, sender_nr, recp_nr, signal_cli_path):
        """Initialize the service."""
        self.sender_nr = sender_nr
        self.recp_nr = recp_nr
        self.signal_cli_path = path.join(signal_cli_path, "signal-cli")

    def send_message(self, message="", **kwargs):
        """Send a message to a user."""

        # Raise an Exception if something goes wrong

        p = subprocess.Popen([self.signal_cli_path, "-u", self.sender_nr, "send", "-m", message, self.recp_nr], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        # Wait for completion
        p.wait()
        output, err = p.communicate()

        ret = p.returncode
        if ret != 0:
            raise Exception("Signal Error {}".format(ret))
