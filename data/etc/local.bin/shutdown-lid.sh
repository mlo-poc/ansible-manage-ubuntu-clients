#!/bin/bash

# Überprüfen, ob der Deckel geschlossen ist
if grep -q closed /proc/acpi/button/lid/LID0/state; then
    # 30 Sekunden warten
    sleep 30

    # Überprüfen, ob der Deckel während der Wartezeit geöffnet wurde
    if grep -q open /proc/acpi/button/lid/LID0/state; then
        exit 0
    fi

    # Andernfalls herunterfahren
    shutdown now
fi
