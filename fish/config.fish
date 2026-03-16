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

### Path extras ###
export GOPATH="/home/$USER/.config/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.cargo/bin"

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
alias ls="exa"
alias l="exa"
alias la="exa"
alias tree="exa --tree --level=4 --icons --git"

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

function fish_greeting
end
