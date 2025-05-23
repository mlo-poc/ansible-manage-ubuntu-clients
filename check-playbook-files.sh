#!/bin/bash

# Überprüfen, ob ein Argument übergeben wurde
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <playbook.yml>"
    exit 1
fi

PLAYBOOK="$1"

# Überprüfen, ob die angegebene Datei existiert
if [ ! -f "$PLAYBOOK" ]; then
    echo "Error: Playbook '$PLAYBOOK' does not exist."
    exit 1
fi

# Suchen nach 'src' in 'copy' Modulen und Überprüfen der Existenz der Dateien
MISSING_FILES=()

while IFS= read -r line; do
    if [[ $line =~ src:\ (.+) ]]; then
        FILE="${BASH_REMATCH[1]}"
        # Entferne eventuelle Leerzeichen
        FILE=$(echo "$FILE" | xargs)
        # Überprüfen, ob die Datei existiert
        if [ ! -f "$FILE" ]; then
            MISSING_FILES+=("$FILE")
        fi
    fi
done < <(grep -E '^\s*src:\s*' "$PLAYBOOK")

# Ausgabe der Ergebnisse
if [ ${#MISSING_FILES[@]} -eq 0 ]; then
    echo "All referenced files in '$PLAYBOOK' are present."
else
    echo "The following files are missing:"
    for file in "${MISSING_FILES[@]}"; do
        echo " - $file"
    done
fi
