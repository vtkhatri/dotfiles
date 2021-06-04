#!/bin/sh

#while xsetroot -name "`date +\"%a %b %d %H:%M\"` | BAT:`acpi | awk '/Charging/ {print \"+\"$4} /Discharging/ {print $4}  /Not charging/ {print \"+\"$5}'` CPU:`uptime | sed -e 's/.*ge: //g' -e 's/, .*//g' -e 's/\.//g'`%"
while xsetroot -name "`date +\"%A %B %d %H:%M\"` | BAT:`acpi | awk '/Charging/ {print \"+\"$4} /Discharging/ {print $4}  /Not charging/ {print \"+\"$5}'` CPU:`uptime | sed -e 's/.*ge: //g' -e 's/, .*//g' -e 's/\.//g'`%"
do
	sleep 10
done &

[ -f ~/.config/xprofile ] && . ~/.config/xprofile

dunst &
exec dbus-launch dwm
