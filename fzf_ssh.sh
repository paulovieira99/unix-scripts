#!/bin/bash
HOST=$( (echo "Cancelar"; awk '/^Host / {print $2}' ~/.ssh/config) | fzf \
    --prompt="Selecione um host: " \
    --height=80% --min-height=20 --border --info=inline \
    --color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7 \
    --color=fg+:#a9b1d6,bg+:#24283b,hl+:#bb9af7 \
    --color=border:#7dcfff,pointer:#f7768e,marker:#9ece6a,header:#e0af68)

if [[ -z "$HOST" || "$HOST" == "Cancelar" ]]; then
    echo -e "\033[1;31mOperação cancelada.\033[0m"
    exit 0
fi

# Conectar ao host selecionado
echo -e "\033[1;32mConectando a $HOST...\033[0m"
ssh "$HOST"

