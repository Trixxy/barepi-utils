#!/bin/bash
echo "--Following is a printout of the latest attached usb devices:\n"
dmesg | grep --regexp='^.*usb.*attached.*$'
echo "\n--To enable other scripts to access those devices, one would need to:"
echo "--give yourself the ability to dial..."
sudo usermod -a -G dialout $USER
echo "--Done"

echo "--Set serial device for Arduino (e.g. ttyUSB0): "
read DEV0
sudo chmod a+rw /dev/$DEV0

echo "#!/bin/bash"   > relay_ctrl.sh
echo "DEVICE=$DEV0" >> relay_ctrl.sh
echo "CMD=\$1" >> relay_ctrl.sh
echo "echo -n \$CMD > /dev/\$DEVICE" >> relay_ctrl.sh

chmod 764 relay_ctrl.sh