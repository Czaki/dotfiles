#!/bin/bash

LANG=en_US

BUILDIN_OUTPUT=$(pactl list sinks | grep  -oP "Name: \K.*pci.*")
BUILDIN_INPUT=$(pactl list sources | grep  -oP "Name: \K.*input.*pci.*")
NCX_USB_OUTPUT=$(pactl list sinks | grep  -oP "Name: \K.*NCX.*")
NCX_USB_INPUT=$(pactl list sources | grep  -oP "Name: \K.*input.*NCX.*")
BLUEZ=$(pactl list sinks | grep  -oP "Name: \K.*bluez.*")

echo "BUILDIN: $BUILDIN_OUTPUT $BUILDIN_INPUT"
echo "NCX_USB: $NCX_USB_OUTPUT $NCX_USB_INPUT"
echo "BLUEZ: $BLUEZ"


if [[ -n $BLUEZ ]]; then
    if [[ -n $NCX_USB_INPUT ]] && [[ $BUILDIN_INPUT == *$(pactl get-default-source)* ]]; then
        pactl set-default-source $NCX_USB_INPUT
    else
        pactl set-default-source $BUILDIN_INPUT
    fi
else
    if [[ -n $NCX_USB_INPUT ]] && [[ $BUILDIN_OUTPUT == *$(pactl get-default-sink)* ]]; then
        pactl set-default-sink $NCX_USB_OUTPUT
        pactl set-default-source $NCX_USB_INPUT
    else
        pactl set-default-sink $BUILDIN_OUTPUT
        pactl set-default-source $BUILDIN_INPUT
    fi
fi



