#/bin/bash
length=$(nmcli connection show --active | grep -b -o "UUID" | cut -d: -f1)
ip=$(ip -f inet addr | grep 'noprefixroute wlp166s0' | awk '{print substr($2, 1, length($2)-3)}')
essid=$(nmcli connection show --active | grep wifi | head -c $length)

if [ -n "$essid" ]; then
    echo 🌐 $essid $ip | head -c 70
fi
