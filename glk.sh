#!/bin/bash

echo install intel firmware
sudo dpkg -i *.deb
sudo dpkg -i --force-overwrite ./tools/firm*.deb

echo copy topology
cp ./tplg/amic/* /lib/firmware/intel/sof-tplg/

#echo get dsdt
#cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
#iasl -d dsdt.dat

#echo get gpio
#cat /sys/kernel/debug/gpio>gpio.txt

echo allow selecting kernel from grub
cp grub /etc/default/grub

chmod +x *.sh
systemctl enable acpid.service

cp 1.sh ~
cp 2.sh ~
cp 3.sh /lib/systemd/system-sleep/

echo setting up hdmi device
sed -i '/load-module module-suspend-on-idle/d' /etc/pulse/default.pa
echo 'load-module module-alsa-sink device=hw:0,5 sink_name=HDMI sink_properties=device.description=HDMI' >> /etc/pulse/default.pa
#echo 'load-module module-alsa-sink device=hw:0,6 sink_name=HDMI2 sink_properties=device.description=HDMI2' >> /etc/pulse/default.pa
#echo 'load-module module-alsa-sink device=hw:0,7 sink_name=HDMI3 sink_properties=device.description=HDMI3' >> /etc/pulse/default.pa
