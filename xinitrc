#!/bin/sh

# old statusbar, for posterity
#while xsetroot -name "`date +\"%a %b %d %H:%M\"` | BAT:`acpi | awk '/Charging/ {print \"+\"$4} /Discharging/ {print $4}  /Not charging/ {print \"+\"$5}'` CPU:`uptime | sed -e 's/.*ge: //g' -e 's/, .*//g' -e 's/\.//g'`%"

# map caps to backspace
xsetkbmap -option caps:backspace

# setting statusbar, very clunky
while xsetroot -name " \
`date +\"%A %B %d %H:%M\"` | \
BAT:`acpi | awk '/Charging/ {print \"+\"$4} /Discharging/ {print $4}  /Not charging/ {print \"+\"$5}'` \
CPU:`uptime | sed -e 's/.*ge: //g' -e 's/, .*//g' -e 's/\.//g'`%\
"
do
	sleep 10
done &

# battery check script
battery_level=`acpi | grep -oP '(?<=, )\d+(?=%)'`
if [ "$battery_level" -le 15 ]
then
	notify-send "Battery low. Battery level is ${battery_level}%!"
elif [ "$battery_level" -le 3 ]
then
	notify-send "Battery critical. Battery level is ${battery_level}%! Suspending..."
	sleep 5
	systemctl suspend
fi

# backgrounds and stuff
[ -f ~/.config/xprofile ] && . ~/.config/xprofile

# notification daemon
dunst &

# message bus daemon
exec dbus-launch dwm
