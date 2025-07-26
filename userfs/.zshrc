autoload -Uz compinit add-zsh-hook up-line-or-beginning-search down-line-or-beginning-search
compinit

eval "$(dircolors -b)"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

setopt autocd
setopt globdots
setopt histignoredups
setopt incappendhistory

HISTFILE="${XDG_RUNTIME_DIR:?}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

PS1='%B%F{green}%n@%M %F{blue}%~ $%b%f '

export PATH="${HOME}/.bin:${HOME}/.cargo/bin:${PATH}"
export SVDIR="${HOME}/.sv"

export LESSHISTFILE=-
export ZFS_COLOR=1

typeset -g -A key

key[Up]='^[[A'
key[Down]='^[[B'

key[Control-Left]='^[[1;5D'
key[Control-Right]='^[[1;5C'

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "${key[Up]}" up-line-or-beginning-search
bindkey "${key[Down]}" down-line-or-beginning-search

bindkey "${key[Control-Left]}" backward-word
bindkey "${key[Control-Right]}" forward-word

function reset_broken_terminal() {
  printf %b '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal

function clear_screen() {
  printf '\x1Bc'
  zle clear-screen
  zle kill-whole-line
}

zle -N clear_screen
bindkey '^L' clear_screen

alias sudo=doas
alias nano=rnano
alias cal="cal -y"

alias f=fastfetch
alias p=pfetch
alias b="cbonsai -li"

function q() {
  while [ $# -gt 0 ]; do
    qrencode -t ansiutf8 -r "$1"
    shift
  done
}

alias shfmt="shfmt -w -d -p -i 2 -ci -sr"
alias shcheck=shellcheck

alias gs="git status"

function gc() {
  if [ $# -gt 0 ]; then
    git commit -m "$*"
  else
    git commit
  fi
}

function push() {
  for remote in github gitlab; do
    git push -f "$remote" "${1:-master}"
  done
}

alias grep="grep --color=auto"
alias diff="diff --color=auto"

alias bat="bat --paging=never --theme=base16 --tabs=4"

alias ls="lsd -A"
alias l="lsd -la"
alias la="lsd -la"
alias ld="lsd -la --total-size"
alias lt="lsd -a --tree"
alias lta="lsd -la --tree"

alias zl="zfs list -t snapshot -s creation -o name,creation"
alias zu="zfs list -t snapshot -s used -o name,used"

function xl() {
  awk '$3 == "xfs"' /proc/mounts
}
alias xu="df -h -t xfs"

function ff() {
  find . -iname "*${*}*"
}

function fn() {
  find "$@" -printf '%T@ %Tc %p\n' | sort -n
}

function fo() {
  find "$@" -printf '%T@ %Tc %p\n' | sort -nr
}

function fd() {
  find /dev/disk/by-id -type l | sort | grep -i "$*"
}

function fl() {
  grep -i "$*" "${HOME}/Documents/Notes/Linux.txt"
}

function tt() {
  nano +-1 "${HOME}/Documents/Notes/TO-DO.txt"
}

function feh() {
  command feh \
    --quiet \
    --auto-zoom \
    --scale-down \
    --image-bg=black \
    --sort=name \
    --version-sort \
    --start-at \
  "$@"
}

function c() {
  code-oss --enable-features=UseOzonePlatform --ozone-platform=wayland "$@" &> /dev/null
}

function laptop() {
  rsync -xaAXHvh --delete \
    --exclude=/.config/alacritty \
    --exclude=/.config/spotify \
    --exclude=/.config/sway \
    --exclude=/.config/waybar \
    --exclude=/.local/state \
    --exclude=/.mozilla \
    --exclude=/.sv \
    --exclude=/.zcompdump \
    ~/ laptop:~/
}
