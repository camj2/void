#!/bin/zsh

autoload -Uz compinit add-zsh-hook up-line-or-beginning-search down-line-or-beginning-search
compinit

export HISTFILE="$XDG_RUNTIME_DIR/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000
setopt INC_APPEND_HISTORY

export PATH="$PATH:$HOME/.bin"

export LESSHISTFILE=-

export ZFS_COLOR=1

eval "$(dircolors -b)"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

setopt autocd
setopt globdots
setopt histignoredups

typeset -g -A key

# showkey -a

key[Up]='^[[A'
key[Down]='^[[B'

# key[Up]="${terminfo[kcuu1]}"
# key[Down]="${terminfo[kcud1]}"

key[Control-Left]='^[[1;5D'
key[Control-Right]='^[[1;5C'

# key[Control-Left]="${terminfo[kLFT5]}"
# key[Control-Right]="${terminfo[kRIT5]}"

bindkey "${key[Control-Left]}" backward-word
bindkey "${key[Control-Right]}" forward-word

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "${key[Up]}" up-line-or-beginning-search
bindkey "${key[Down]}" down-line-or-beginning-search

PS1='%B%F{green}%n@%M %F{blue}%~ $%b%f '

function reset_broken_terminal() {
  printf %b '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal

# function clear_scrollback_buffer {
#   clear
#   zle
#   zle .reset-prompt
#   zle -R
#   zle backward-kill-line
# }

# zle -N clear_scrollback_buffer

# bindkey '^L' clear_scrollback_buffer

function clear_screen() {
    printf '\x1Bc'
    zle clear-screen
    zle kill-whole-line
}

zle -N clear_screen
bindkey '^L' clear_screen

# function clear-screen-and-scrollback() {
#     echoti civis > "$TTY"
#     printf %b '\e[H\e[2J' > "$TTY"
#     zle .reset-prompt
#     zle -R
#     printf %b '\e[3J' > "$TTY"
#     echoti cnorm > "$TTY"
#     zle kill-whole-line
# }

# zle -N clear-screen-and-scrollback
# bindkey '^L' clear-screen-and-scrollback

alias sudo=doas

alias cal="cal -y"

alias grep="grep --color=auto"
alias diff="diff --color=auto"

alias bat="bat --paging=never --theme=base16 --tabs=4"

alias la="lsd -la"
alias l="lsd -la"
alias ls="lsd -A"
alias lt="lsd -A --tree"
alias lta="lsd -la --tree"

alias shfmt="shfmt -d -p -i 2 -ci -sr"
alias shcheck=shellcheck

alias gs="git status"

# alias vsv="vsv -d /home/cameron/.sv"
export SVDIR="$HOME/.sv"

alias qr="qrencode -t ansiutf8 -r"

alias zl="zfs list -t snapshot -s creation -o name,creation"
alias zu="zfs list -t snapshot -s used -o name,used"

alias network="ssh server@server"
alias backup="ssh server@backup"

alias code-oss="code-oss --enable-features=UseOzonePlatform --ozone-platform=wayland &> /dev/null"

. "$HOME/.cargo/env"
