#!/bin/bash
# Alterna play/pause no player ativo (mesma ação do botão do widget do eww).
#
# O widget escuta `playerctl metadata -F` em scripts/music.sh, e esse listener
# também recebe as mudanças de status, então o ícone (play/pause) se atualiza
# sozinho — não é preciso avisar o eww.

status="$(playerctl status 2>/dev/null)"

if [ -z "$status" ]; then
    exit 0
fi

exec playerctl play-pause
