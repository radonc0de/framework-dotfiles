#!/bin/bash

acpi_out=$(acpi -i)
acpi=$(echo $acpi_out | grep -v unavailable | grep -E '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
time=$(echo "$acpi" | grep -o -E '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
status=$(echo "$acpi" | awk '{print $3}')
capacity=$(echo "$acpi" | grep -o -E '[0-9]*%' | head -n 1 | awk '{sub("%", ""); print $0}')


if [ "$status" = "Charging," ]; then
    echo 🔋⚡⚡@ $(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep energy-rate | awk '{printf $2 " " $3}') $capacity%
elif [ "$capacity" -le 20 ]; then 
    echo 🪫⚠️ $capacity% $time
elif [ "$capacity" -le 30 ]; then 
    echo 🪫 $capacity% $time
elif [ -n "$time" ]; then
    echo 🔋 $capacity% $time
elif echo $acpi_out | grep -q "100%"; then
    echo "🔋 100%"
fi

