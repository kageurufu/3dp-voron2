#!/bin/sh

cd "$HOME/klipper"

sudo systemctl stop klipper klipper_mcu

make clean

cp pi.config .config
make -j5
make flash

cp octopro.config .config
make -j5
ls /dev/serial/by-id/usb-Klipper_stm32f446xx_* | while read klippermcu; do
  make flash FLASH_DEVICE="${klippermcu}"
done

# cp skr.config .config
# make -j5
# ls /dev/serial/by-id/usb-Klipper_* | while read klippermcu; do
#   ./scripts/flash-sdcard.sh "$klippermcu" btt-skr-turbo-v1.4
# done

sudo systemctl start klipper klipper_mcu
