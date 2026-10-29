#!/bin/bash
# Alterna a visibilidade de uma janela do eww.
#
# Uso: toggle.sh <janela> <variavel_de_reveal> [variavel_extra]
#
# - Sem `sleep` artificial antes de responder ao clique.
# - Serializa os cliques com flock para o fechamento atrasado não competir
#   com uma reabertura (era isso que fazia a animação sumir).
# - Só abre a janela quando o reveal está em false, garantindo que a
#   animação de entrada sempre execute.

set -u

win="${1:?uso: toggle.sh <janela> <variavel> [variavel_extra]}"
var="${2:?uso: toggle.sh <janela> <variavel> [variavel_extra]}"
extra="${3:-}"

eww=/usr/bin/eww
lock="/tmp/eww-${win}.lock"

# Um lock por janela. O `exec` mantém o fd aberto durante todo o script.
# Se um clique anterior travar (eww sem responder), este clique é descartado
# em vez de deixar a interface inteira travada.
exec 9>"$lock"
flock -w 2 -x 9 || exit 0

rev="$(timeout 5 "$eww" get "$var" 2>/dev/null || true)"

if [ "$rev" = "true" ]; then
    # Esconde com animação. Fecha a janela após o tempo da animação,
    # independente da condição (evita ficar presa caso eww não responda
    # na verificação posterior).
    timeout 5 "$eww" update "${var}=false" >/dev/null 2>&1
    if [ -n "$extra" ]; then
        timeout 5 "$eww" update "${extra}=false" >/dev/null 2>&1
    fi

    (
        # Solta o lock herdado antes de dormir
        exec 9>&-
        sleep 0.35
        # Fecha de forma direta e atômica com lock
        flock -w 2 -x "$lock" bash -c '
            timeout 5 "$3" close "$1" >/dev/null 2>&1
            exit 0
        ' _ "$win" "$var" "$eww"
    ) >/dev/null 2>&1 &

    exit 0
fi

# Daqui pra baixo a janela está escondida (rev=false).
# Se já estiver aberta, `eww open` recria a surface; como var está false,
# ela nasce escondida e a animação de entrada roda do zero.
timeout 5 "$eww" open "$win" >/dev/null 2>&1
timeout 5 "$eww" update "${var}=true" >/dev/null 2>&1
