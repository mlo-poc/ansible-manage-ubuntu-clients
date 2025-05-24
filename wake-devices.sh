#!/bin/bash

# default IP-Range (historic)
ip_range="10.10.70.0/26"
# Überprüfen, ob ein CLI-Parameter übergeben wurde
if [ "$#" -gt 0 ]; then
    ip_range="$1"
fi


# Überprüfen, ob arp oder ip neigh verfügbar ist
if command -v arp >/dev/null 2>&1; then
    get_mac_command="arp -n"
elif command -v ip >/dev/null 2>&1; then
    get_mac_command="ip neigh show"
else
    echo "Error: Neither 'arp' nor 'ip' command is available. Exiting."
    exit 1
fi

# Zähler für WoL-Anfragen
wol_count=0

# Alle aktiven IP-Adressen im Netzwerk scannen und MAC-Adressen abrufen
echo "Gathering information on reachable hosts in network segment"
echo "$(ipcalc -b $ip_range)"
for ip in $(nmap -sn -n $ip_range | grep 'Nmap scan report for' | awk '{print $5}'); do

    # Ermitteln der MAC-Adresse
    if [ "$get_mac_command" == "arp -n" ]; then
        mac=$($get_mac_command "$ip" | awk '/^[^ ]/ {print $3}')
    else
        mac=$($get_mac_command "$ip" | awk '{print $5}')
    fi
    
    if [ -n "$mac" ]; then
	echo "$ip: $(wakeonlan $mac)"
	((wol_count++))
    else
	echo "no MAC fond for host at $ip"
    fi
done

echo "Total WoL requests sent: $wol_count"
