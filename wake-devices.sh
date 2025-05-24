#!/bin/bash

# IP-Range
ip_range="10.10.70.0/24"

# Alle aktiven IP-Adressen im Netzwerk scannen und MAC-Adressen abrufen
for ip in $(nmap -sn $ip_range | grep 'Nmap scan report for' | awk '{print $5}'); do
    # Ermitteln der MAC-Adresse
    mac=$(arp -n "$ip" | awk '/^[^ ]/ {print $3}')
    
    if [ -n "$mac" ]; then
        echo "Sende Wake-on-LAN an $ip ($mac)"
        wakeonlan "$mac"
    else
        echo "Keine MAC-Adresse für $ip gefunden."
    fi
done
