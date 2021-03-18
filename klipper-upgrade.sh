#!/bin/sh

cd "$HOME/klipper"
make clean
make -j5

systemctl stop klipper
ls /dev/serial/by-id/usb-Klipper_* | while read klippermcu; do
  ./scripts/flash-sdcard.sh "$klippermcu" btt-skr-turbo-v1.4
done
systemctl start klipper
