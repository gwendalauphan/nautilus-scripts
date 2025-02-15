#!/bin/bash

# Définition des répertoires
SCRIPT_DIR="$(pwd)/scripts"  # Chemin absolu du dossier scripts/
NAUTILUS_SCRIPTS_DIR="$HOME/.local/share/nautilus/scripts"

# Vérifie si le dossier scripts/ existe
if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Erreur : Le dossier 'scripts/' n'existe pas dans $(pwd)"
    exit 1
fi

# Création du dossier Nautilus si inexistant
mkdir -p "$NAUTILUS_SCRIPTS_DIR"

# Parcours des fichiers dans scripts/
for script in "$SCRIPT_DIR"/*; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        target_link="$NAUTILUS_SCRIPTS_DIR/$script_name"

        # Supprime le lien symbolique s'il existe déjà
        if [ -L "$target_link" ]; then
            rm "$target_link"
        fi

        # Crée un lien symbolique
        ln -s "$script" "$target_link"
        echo "Lien créé : $target_link → $script"
    fi
done

echo "Tous les scripts sont maintenant accessibles dans Nautilus !"

