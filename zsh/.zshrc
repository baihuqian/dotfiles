setopt CORRECT
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
DOTFILE=$HOME/dotfiles
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

    # Plugins:
    # aws: add shell completion of aws commands
    # brew: add shell completion of brew commands, and alias brews="brew list -1"
    # osx:
    # | Command         | Description                                      |
    # | :-------------- | :----------------------------------------------- |
    # | `tab`           | Open the current directory in a new tab          |
    # | `ofd`           | Open the current directory in a Finder window    |
    # | `pfd`           | Return the path of the frontmost Finder window   |
    # | `pfs`           | Return the current Finder selection              |
    # | `cdf`           | `cd` to the current Finder directory             |
    # | `pushdf`        | `pushd` to the current Finder directory          |
    # | `quick-look`    | Quick-Look a specified file                      |
    # | `man-preview`   | Open a specified man page in Preview app         |
    # | `showfiles`     | Show hidden files                                |
    # | `hidefiles`     | Hide the hidden files                            |
    # autojump: use j key to jump anywhere
    # zsh-syntax-highlighting: highlight shell syntax
    # Install zsh-syntax-highlighting:
    # If we want to activate it using oh-my-zsh plugin, don't install it with brew
    # cd ~/.oh-my-zsh/custom/plugins/; git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    # Use `ESC` or `CTRL-[` to enter `Normal mode`.
    #
    # vi-mode:
    # History
    # -------
    # - `ctrl-p` : Previous command in history
    # - `ctrl-n` : Next command in history
    # - `/`      : Search backward in history
    # - `n`      : Repeat the last `/`
    #
    #
    # Mode indicators
    # ---------------
    # *Normal mode* is indicated with red `<<<` mark at the right prompt, when it
    # wasn't defined by theme.
    #
    # Vim edition
    # -----------
    # - `v`   : Edit current command line in Vim
    #
    # Movement
    # --------
    # - `$`   : To the end of the line
    # - `^`   : To the first non-blank character of the line
    # - `0`   : To the first character of the line
    # - `w`   : [count] words forward
    # - `W`   : [count] WORDS forward
    # - `e`   : Forward to the end of word [count] inclusive
    # - `E`   : Forward to the end of WORD [count] inclusive
    # - `b`   : [count] words backward
    # - `B`   : [count] WORDS backward
    # - `t{char}`   : Till before [count]'th occurrence of {char} to the right
    # - `T{char}`   : Till before [count]'th occurrence of {char} to the left
    # - `f{char}`   : To [count]'th occurrence of {char} to the right
    # - `F{char}`   : To [count]'th occurrence of {char} to the left
    # - `;`   : Repeat latest f, t, F or T [count] times
    # - `,`   : Repeat latest f, t, F or T in opposite direction
    #
    # Insertion
    # ---------
    # - `i`   : Insert text before the cursor
    # - `I`   : Insert text before the first character in the line
    # - `a`   : Append text after the cursor
    # - `A`   : Append text at the end of the line
    # - `o`   : Insert new command line below the current one
    # - `O`   : Insert new command line above the current one
    #
    # Delete and Insert
    # -----------------
    # - `ctrl-h`      : While in *Insert mode*: delete character before the cursor
    # - `ctrl-w`      : While in *Insert mode*: delete word before the cursor
    # - `d{motion}`   : Delete text that {motion} moves over
    # - `dd`          : Delete line
    # - `D`           : Delete characters under the cursor until the end of the line
    # - `c{motion}`   : Delete {motion} text and start insert
    # - `cc`          : Delete line and start insert
    # - `C`           : Delete to the end of the line and start insert
    # - `r{char}`     : Replace the character under the cursor with {char}
    # - `R`           : Enter replace mode: Each character replaces existing one
    # - `x`           : Delete [count] characters under and after the cursor
    # - `X`           : Delete [count] characters before the cursor
    #

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
alias gcp="git cherry-pick"
function grh () {
  read "ans?git reset --hard?(yN)"
  case $ans in
    Y|y ) git reset --hard ;;
    * ) ;;
  esac
}

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
# Depend on GNU date
epochdate() { date -ud "$@" +%s }

humandate() { date -ud @"$@" }

# configure fuzzy autocomplete on tab
zstyle ':completion:*' matcher-list '' \
'm:{a-z\-}={A-Z\_}' \
'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'

# OS X specific
if [[ "$OSTYPE" == "darwin"* ]]; then
   plugins=(aws brew  autojump vi-mode zsh-syntax-highlighting)

  # tmux integration with iTerm
  alias tmux='tmux -CC'
  alias ta='tmux -CC attach'

  # Autojump
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

  # Path with brew installation
  export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$(brew --prefix)/bin:$(brew --prefix)sbin:/usr/bin:/bin:/usr/sbin:/sbin"
  export MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$(brew --prefix)/man:$MANPATH"

  # rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - zsh)"

  # Eject all mounted physical disks on OSX
  # Same as Alfred ejectall command
  function ejectall() {
      osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
  }

  # Hashes
  hash -d doc=~/Documents
  hash -d dow=~/Downloads

  alias ssh2ec2='ssh -i ~/.ssh/unifi-controller.pem ubuntu@18.217.9.248'
  alias ssh62ec2='ssh -i ~/.ssh/unifi-controller.pem ubuntu@2600:1f16:67b:a300:f77a:173:3ea2:b5d1'
fi # end of OS X specific

# Linux specific
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  #rbenv
  export PATH="$HOME/.rbenv/bin:$HOME/.cargo/bin:$PATH"
  eval "$(rbenv init -)"

  # autojump
  . /usr/share/autojump/autojump.sh

  alias ssh2ec2='ssh -i ~/.ssh/unifi-controller.pem ubuntu@18.217.9.248'
  alias ssh62ec2='ssh -i ~/.ssh/unifi-controller.pem ubuntu@2600:1f16:67b:a300:f77a:173:3ea2:b5d1'

  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
# Stuff comes with oh-my-zsh
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

source $ZSH/oh-my-zsh.sh

# pipx, midway
export PATH="$PATH:$HOME/.local/bin:/usr/local/bin"


