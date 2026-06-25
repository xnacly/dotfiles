#██╗  ██╗███╗   ██╗ █████╗  ██████╗██╗  ██╗   ██╗███████╗    ███████╗██╗███████╗██╗  ██╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
#╚██╗██╔╝████╗  ██║██╔══██╗██╔════╝██║  ╚██╗ ██╔╝██╔════╝    ██╔════╝██║██╔════╝██║  ██║    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
# ╚███╔╝ ██╔██╗ ██║███████║██║     ██║   ╚████╔╝ ███████╗    █████╗  ██║███████╗███████║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
# ██╔██╗ ██║╚██╗██║██╔══██║██║     ██║    ╚██╔╝  ╚════██║    ██╔══╝  ██║╚════██║██╔══██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
#██╔╝ ██╗██║ ╚████║██║  ██║╚██████╗███████╗██║   ███████║    ██║     ██║███████║██║  ██║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝   ╚══════╝    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
# xnacly's fish config
# https://github.com/xnacly

### set configs ###
export EDITOR="nvim"
export VISUAL="nvim"
set -g fish_key_bindings fish_vi_key_bindings
export OLLAMA_API_KEY="owui_Gi1dZuEEdDhK1yrtPFswjcHXhGhUUVQUIpZBn6py1MY"

### Path extras ###
export GOPATH="/home/$USER/.config/go"
fish_add_path --global --move "$GOPATH/bin" "$HOME/.cargo/bin" "$HOME/.local/bin"

### aliases ###

function dev --description "Wrapper for nix develop with some options"
    nix develop -c $SHELL $argv
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

function temp --description "Create and cd into temp directory"
    set -l dir (mktemp --directory)
    cd $dir
end

function temp_clone --description "Clone repo into temp dir"
    temp
    git clone $argv temprepo
    cd temprepo
end

alias z=zellij

# extended shutdown
alias ss="shutdown"

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."

# vim
alias vim="nvim"

# ls
alias ls="eza"
alias l="eza"
alias la="eza"
alias tree="eza --tree --level=4 --icons --git"

# github
alias gs="git status"
alias ga="git add -A"
alias gc="git commit -m"
alias gps="git push"
alias gpl="git pull"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.config"
export WAKATIME_HOME="$HOME/.config"
export BAT_THEME="Catppuccin Latte"

# Prefer Wayland-native backends while keeping X11 fallback for mixed sessions.
export MOZ_ENABLE_WAYLAND="1"
export ELECTRON_OZONE_PLATFORM_HINT="auto"
export NIXOS_OZONE_WL="1"
export GDK_BACKEND="wayland,x11"
export QT_QPA_PLATFORM="wayland;xcb"
export SDL_VIDEODRIVER="wayland"
export CLUTTER_BACKEND="wayland"

function fish_greeting
end
