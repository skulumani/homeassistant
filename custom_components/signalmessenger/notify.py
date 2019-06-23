"""
Signal Messenger for notify component.
Place this in `homeassistant/components/notify/signalmessenger.py` 
"""

from os import path
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
CONF_GROUP = 'group'
CONF_SIGNAL_CLI_PATH = 'signal_cli_path'
CONF_SIGNAL_CONF_PATH = 'signal_conf_path'

PLATFORM_SCHEMA = PLATFORM_SCHEMA.extend({
    vol.Optional(CONF_SENDER_NR): cv.string,
    vol.Optional(CONF_RECP_NR): cv.string,
    vol.Optional(CONF_GROUP): cv.string,
    vol.Optional(CONF_SIGNAL_CLI_PATH): cv.string,
    vol.Optional(CONF_SIGNAL_CONF_PATH): cv.string,
})


def get_service(hass, config, discovery_info=None):
    """Get the Join notification service."""
    sender_nr = config.get(CONF_SENDER_NR)
    recp_nr = config.get(CONF_RECP_NR)
    group = config.get(CONF_GROUP)
    signal_cli_path = config.get(CONF_SIGNAL_CLI_PATH)
    signal_conf_path = config.get(CONF_SIGNAL_CONF_PATH)

    if sender_nr is None or signal_cli_path is None:
        _LOGGER.error("Please specify sender_nr and signal_cli_path")
        return False
    if not ((recp_nr is None) ^ (group is None)):
        _LOGGER.error("Either recp_nr or group is required")
        return False

    return SignalNotificationService(sender_nr, recp_nr, group,
                                     signal_cli_path, signal_conf_path)


class SignalNotificationService(BaseNotificationService):
    """Implement the notification service for Join."""


    def __init__(self, sender_nr, recp_nr, group, signal_cli_path, signal_conf_path):
        """Initialize the service."""
        self.sender_nr = sender_nr
        self.recp_nr = recp_nr
        self.group = group
        self.signal_cli_path = path.join(signal_cli_path, "signal-cli")
        self.signal_conf_path = signal_conf_path

    def send_message(self, message="", **kwargs):
        """Send a message to a user."""

        try:
            from pydbus import SystemBus
            bus = SystemBus()
            signal_send = SystemBus().get('org.asamk.Signal')
        except:
            _LOGGER.error("pydbus import broken")

        # Establish default command line arguments
        mainargs = [self.signal_cli_path]
        if self.signal_conf_path is not None:
            mainargs.extend(['--config', self.signal_conf_path])

        mainargs.extend(["-u", self.sender_nr, "send"])
        if self.group is not None:
            mainargs.extend(["-g", self.group])
        else:
            mainargs.extend([self.recp_nr])

        mainargs.extend(["-m", message])

        # Add any "data":{"attachments":<value>} values as attachments to send.
        # Supports list to send multiple attachments at once.
        if kwargs is not None:
            data = kwargs.get('data',None)
            if data and data.get('attachments',False):
                attachments = kwargs['data']['attachments']
                mainargs.append('-a')
                if isinstance(attachments,str):
                    mainargs.append(attachments)
                else:
                    mainargs.extend(attachments)

        # try to send a message using dbus and revert if it fails
        try:
            # if kwargs is not None:
            #     data = kwargs.get('data', None)
            #     if data and data.get('attachments', False):
            #         attachments = kwargs['data']['attachments']
            #         if isinstance(attachments, str):
            #             signal_send.sendMessage(message, [attachments], [self.recp_nr])
            # else:
            signal_send.sendMessage(message, [], [self.recp_nr])
        except:
            # Raise an Exception if something goes wrong
            p = subprocess.Popen(mainargs, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

            # Wait for completion
            p.wait()
            output, err = p.communicate()
            ret = p.returncode

            if ret != 0:
                raise Exception("Signal Error %d: '%s'" % (ret, err))
