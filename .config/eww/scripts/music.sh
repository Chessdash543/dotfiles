#!/bin/bash
urldecode() { printf '%b' "${1//%/\\x}"; }

base_dir="$HOME/.config/eww/"
image_file="${base_dir}image.jpg"

mkdir -p "$base_dir"

playerctl metadata -F -f '{{playerName}}|{{title}}|{{artist}}|{{mpris:artUrl}}|{{status}}|{{mpris:length}}|{{xesam:url}}' | while IFS='|' read -r name title artist artUrl status length fileUrl; do
    if [[ -n "$length" && "$length" =~ ^[0-9]+$ ]]; then
        len_sec=$(( (length + 500000) / 1000000 ))
        mins=$((len_sec / 60))
        secs=$((len_sec % 60))
        lengthStr=$(printf "%d:%02d" "$mins" "$secs")
    else
        len_sec=""
        lengthStr=""
    fi
    set_art=false
    if [[ "$artUrl" =~ ^https?:// ]]; then
        tmp_image="${image_file}.tmp"
        if wget -q -O "$tmp_image" "$artUrl"; then
            mv "$tmp_image" "$image_file" && set_art=true
        fi
    elif [[ "$artUrl" =~ ^file:// ]]; then
        local_path="${artUrl#file://}"
        local_path=$(urldecode "$local_path")
        if cp "$local_path" "$image_file" 2>/dev/null; then
            set_art=true
        fi
    elif [[ -f "$artUrl" ]]; then
        cp "$artUrl" "$image_file" 2>/dev/null && set_art=true
    fi
    if [[ "$set_art" == false && -n "$fileUrl" ]]; then
        local_file="${fileUrl#file://}"
        local_file=$(urldecode "$local_file")
        if [[ -f "$local_file" ]]; then
            tmp_image="${image_file}.tmp"
            if ffmpeg -y -i "$local_file" -an -vcodec copy -vframes 1 "$tmp_image" 2>/dev/null && [[ -f "$tmp_image" ]]; then
                mv "$tmp_image" "$image_file" && set_art=true
            else
                rm -f "$tmp_image"
            fi
        fi
    fi
    if [[ "$set_art" == false ]]; then
        cp "${base_dir}scripts/cover.png" "$image_file"
    fi
    jq -n -c \
        --arg name "$name" \
        --arg title "$title" \
        --arg artist "$artist" \
        --arg artUrl "file://$image_file" \
        --arg status "$status" \
        --arg length "$len_sec" \
        --arg lengthStr "$lengthStr" \
        '{name: $name, title: $title, artist: $artist, thumbnail: $artUrl, status: $status, length: $length, lengthStr: $lengthStr}'
done
