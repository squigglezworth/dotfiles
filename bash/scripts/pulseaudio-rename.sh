#!/bin/bash

echo 'Renaming speakers...'
pacmd 'update-sink-proplist alsa_output.pci-0000_09_00.0.analog-stereo device.description="Speakers"'
echo 'Renaming Motherboard...'
pacmd 'update-sink-proplist alsa_output.pci-0000_0b_00.6.iec958-stereo device.description="Motherboard"'
echo 'Renaming Headset...'
pacmd 'update-sink-proplist alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo device.description="Headset"'

pacmd 'update-source-proplist alsa_input.pci-0000_09_00.0.analog-stereo device.description="Mixer - Mic"'
