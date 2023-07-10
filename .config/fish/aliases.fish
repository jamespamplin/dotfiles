# dotfile bare git repo management
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias dotfiles='env GIT_WORK_TREE=$HOME GIT_DIR=$HOME/.cfg/'

# ls
alias l="ls -ahlF"

# git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -v"
alias gca="git commit -v -a -m"
alias gcm="git commit -m"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log --stat"
alias glog="git log --oneline --decorate --graph --all"
alias gp="git push"
alias gst="git status --show-stash"
alias gcz="git-cz"
