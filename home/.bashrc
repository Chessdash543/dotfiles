#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\[\033[35m\]\u\[\033[0m\]@\[\033[34m\]\h\[\033[0m\] \W]\$ '
alias cairo-dock='LD_PRELOAD=/usr/lib/libicalss.so cairo-dock -d .config/cairo-dock-panel'
