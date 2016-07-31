setopt COMPLETE_IN_WORD
setopt CORRECT
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
DOTFILE=$HOME/dotfiles
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

export DEVBOX="baihqian.desktop.amazon.com"
export UBUNTU="u5065f33c570156d5ef2f"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Git alias
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gai="git add -i"
alias gb="git branch"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gc="git commit"
alias gca="git commit --amend"
alias gm="git merge"
alias gpl="git pull"
alias gplr="git pull -r"
alias gps="git push"
alias gpsd="git push --delete origin"
alias gs="git status"
alias gsh="git show"
#alias gl="git log --pretty=oneline"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias grb="git rebase"
alias grbm="git rebase mainline"
alias grbi="git rebase -i"
alias gd="git diff"
alias gdm="git diff origin/mainline"
alias grh="git reset --hard"
alias gcp="git cherry-pick"

# Common alias
alias zconf="vim ~/.zshrc"
alias zsource="source ~/.zshrc"
alias which='which -a'
alias rssh='sshrc'

# Go up n times
u () {
    set -A ud
    ud[1+${1-1}]=
    cd ${(j:../:)ud}
}

# Time conversion
epochdate() { /bin/date -ud "$@" +%s }

humandate() { /bin/date -ud @"$@" }

# tmux integration with iTerm
alias tmux='tmux -CC'
alias ta='tmux -CC attach'

# Autojump
if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
elif [[ $(hostname) == $UBUNTU ]]; then
    [[ -s /home/local/ANT/baihqian/.autojump/etc/profile.d/autojump.sh ]] && source /home/local/ANT/baihqian/.autojump/etc/profile.d/autojump.sh
    autoload -U compinit && compinit -u
fi

# Autoenv
[ -s /usr/local/opt/autoenv/activate.sh ] && source /usr/local/opt/autoenv/activate.sh

# OS X specific
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Plugins:
    # autojump: use j key to jump anywhere
    # zsh-syntax-highlighting: highlight shell syntax
    # Install zsh-syntax-highlighting:
    # cd ~/.oh-my-zsh/custom/plugins/; git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    plugins=(autojump zsh-syntax-highlighting)

    # Path with brew installation
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export MANPATH="usr/local/opt/coreutils/libexec/gnuman:/usr/local/man:$MANPATH"

    # Eject all mounted physical disks on OSX
    # Same as Alfred ejectall command
    function ejectall() {
        osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
    }

# Hashes
    hash -d doc=~/Documents
    hash -d dow=~/Downloads
fi # end of OS X specific

# Amazon laptop
if [[ $(hostname) == "ac87a31a030f" ]]; then
    # Create alias for fast ssh to desktop
    alias ssha="/usr/local/bin/mssh -A $DEVBOX"
    alias sshu="/usr/local/bin/mssh $UBUNTU" # Don't forward ssh-agent to Ubuntu
    export SSH_AUTH_SOCK=$MSSH_AUTH_SOCK
    # go
    export GOROOT=/usr/local/opt/go/libexec
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# Ubuntu
if [[ $(hostname) == $UBUNTU ]]; then
    plugins=(autojump zsh-syntax-highlighting)
    alias ssha="ssh -A $DEVBOX"

    export VMNAME="RHEL5 64-bit desktop"
    alias stopvm="VBoxManage controlvm $VMNAME savestate"
    function reboot() {
        stopvm
        sudo shutdown -r now
    }

    function startvm() {
        nohup VBoxHeadless -s $VMNAME >/dev/null 2>&1 &
    }

    # Midway SSH credential
    function restartssh() {
        killall ssh-agent
        eval `ssh-agent`
        ssh-add -s libeToken.so
    }
    restartssh
fi

# Dev Box specific
if [[ $(hostname) == $DEVBOX ]]; then
  source $DOTFILE/zsh/devdskzshrc
fi # end of DEVBOX setup

source $ZSH/oh-my-zsh.sh
