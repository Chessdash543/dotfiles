#!/bin/bash

# Uptime
uptime=$(uptime -p | sed 's/up //' | sed 's/ days,/d/;s/ day,/d/;s/ hours,/h/;s/ hour,/h/;s/ minutes/m/;s/ minute/m/;s/ weeks,/w/;s/ week,/w/')

# CPU usage (%)
cpu=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{printf "%.0f", $2 + $4}')

# Memory
mem_total=$(free -h | awk '/^Mem:/ {print $2}')
mem_used=$(free -h | awk '/^Mem:/ {print $3}')

# Kernel
kernel=$(uname -r | cut -d- -f1)

echo "{\"text\": \" ${cpu}%  ${mem_used}/${mem_total}  ${uptime}  ${kernel}\", \"class\": \"system-info\"}"
