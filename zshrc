# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# unalias the garbage that comes with oh-my-zsh
unalias -m '*'

# initialize base tmux layout
ray() {
    tmux split-window -v -p 30
    tmux split-window -h -p 50
}

# helper that brings over aliases when ssh
function s() {
    scp ~/.bashrc $1:/tmp/.bashrc_temp
    ssh -t $1 "bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
}

# ls after every cd
function chpwd() {
    ls -l --color=auto
}

# arrow keys for moving around words
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# git aliases
alias gs="git status"
alias gch="git checkout"
alias gd="git diff"
alias gm="git merge"
alias gi="git init"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add ."
alias gcmsg="git commit -m"
alias gg="git gui"
alias gf="git fetch"
alias gr="git reset"
alias grh="git reset --hard"
alias ggpush="git push origin HEAD"
alias ggpull="git pull origin HEAD"
alias gpl="git pull"
alias gcb="git checkout -b"

# other aliases
alias ls="ls -l --color=auto"
alias sa="sudo apt"
alias v="vim"
alias t="tmux"

# BE AT END
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
