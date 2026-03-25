#!/bin/sh

WLAN_IF="iwx0"
ETH_IF="em0"

get_time() {
    date "+%H:%M  %d.%m.%Y"
}

get_net() {
    # Ethernet zuerst prüfen
    eth_status=$(ifconfig "$ETH_IF" 2>/dev/null | awk '/status:/ { print $2 }')
    if [ "$eth_status" = "active" ]; then
        printf "ETH connected"
        return
    fi

    # sonst Wifi
    wifi_status=$(ifconfig "$WLAN_IF" 2>/dev/null | awk '/status:/ { print $2 }')
    if [ "$wifi_status" = "active" ]; then
        nwid=$(ifconfig "$WLAN_IF" | awk '/nwid/ { print $2 }')
        sig=$(ifconfig "$WLAN_IF" | awk 'match($0, /[0-9]+%/) { print substr($0,RSTART,RLENGTH) }')
        printf "WIFI %s %s" "$nwid" "$sig"
    else
        printf "NET offline"
    fi
}

get_batt() {
    pct=$(apm -l)
    ac=$(apm -a)
    rem=$(apm -m)
    if [ "$ac" = "1" ]; then
        printf "CHR %s%%" "$pct"
    else
        printf "BAT %s%% (%smin)" "$pct" "$rem"
    fi
}

while true; do
    echo "%{l}  $(get_time)%{r}$(get_net)   $(get_batt)  "
    sleep 5
done