#!/bin/bash
nutzername="gbg"
addgroup legonxt
adduser $nutzername legonxt
echo 'SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="0694", ATTR{idProduct}=="0002", SYMLINK+="legonxt-%k", GROUP="legonxt", MODE="0660"'  >> /etc/udev/rules.d/45-legonxt.rules
