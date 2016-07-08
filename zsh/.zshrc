setopt COMPLETE_IN_WORD
setopt CORRECT
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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
function gps {
  if [ $# -eq 1 ]; then
    git push
  else
    git push origin $1:mainline
  fi
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
    ## Env Variables
    export SCALA_HOME="/usr/local/share/scala"
    export PATH_SYSTEM="/opt/systems/bin:/home/baihqian/.autojump/bin:/usr/NX/bin:/bin:/usr/bin:/home/baihqian/bin:/sbin"
    export PATH="/usr/kerberos/bin:/usr/local/bin:/apollo/bin:/apollo/env/SDETools/bin:$PATH_SYSTEM:/apollo/env/envImprovement/bin:$SCALA_HOME/bin"
    export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short  # same as '--layout short'
    export BRAZIL_WORKSPACE_GITMODE=1             # same as '--gitMode' or '-g'

    # Automatically run kinit if credentials are outdated
    alias checkkinit="if ! klist -s; then kinit -f; fi &&"
    alias bb="checkkinit brazil-build"
    alias pr="checkkinit post-review"
    alias git="checkkinit git"
    alias bbcr="bb clean && bb release"

    alias ack="/bin/ack"

    stty erase "^?" # Prevent backspace to produce ^?

    plugins=()

    ubuntu_ip=`nslookup $UBUNTU.ant.amazon.com | tac | egrep -m 1 . | cut -d ' ' -f 2`
    source_ip=`echo $SSH_CLIENT | cut -d ' ' -f 1`
    if [ "$ubuntu_ip" != "$source_ip" ]; then
        # SSH credential forwarding
        AGENT_SOCKET=$HOME/.ssh/.ssh-agent-socket
        AGENT_INFO=$HOME/.ssh/.ssh-agent-info
        if [[ -s "$AGENT_INFO" ]]; then
            source $AGENT_INFO
        fi

        if [[ -z "$SSH_AGENT_PID" || "$SSH_AGENT_PID" != `pgrep -u $USER ssh-agent` ]]; then
            echo "Re-starting Agent for $USER"
            pkill -15 -u $USER ssh-agent
            rm -rf $AGENT_SOCKET
            eval `ssh-agent -s -a $AGENT_SOCKET`
            echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > $AGENT_INFO
            echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> $AGENT_INFO
            ssh-add ~/.ssh/midway_rsa
        else
            echo "Agent Already Running"
        fi
    else
        echo "Use Midway credential from Ubuntu desktop"
    fi

    alias ssh2hc="ssh2hc --ssh 'sshrc'"
    function ssh2pe() {
        rssh -i ~/.ssh/vpn_instance_$1.pem ec2-user@$2
    }

    ## Create workspace and download the package
    function createws() {
        cd /workplace/$USER
        brazil ws --create -n $1
        cd $1
    }

    function cop() {
        echo "Do you want to checkout package $1 at `pwd`? [yN]"
        read yN 
        case $yN in
            Y|y ) brazil ws use -p $1;;
            * ) ;;
        esac
    }

    alias usevs="brazil ws use -vs"
    alias avs="usevs WoodchipperAsterixService/development"
    alias ovs="usevs WoodchipperObelix/development"
    alias fvs="usevs WoodchipperFulliautomatix/dev-7"
    alias gvs="usevs WoodchipperGetafix/dev"
    alias vvs="usevs WoodchipperVitalstatistix/development"
    alias ivs="usevs WoodchipperImpedimenta/development"
    alias syncvs="brazil ws sync --md"

    alias pullws="checkkinit brazil ws sync --metadata && brazil ws --pull --rebase"
    alias pbws="checkkinit brazil ws sync --metadata && brazil ws --pull --rebase && brazil-recursive-cmd-parallel --allPackages brazil-build"

    alias auto-console='/workplace/baihqian/VPCOpsTools/src/VpcOpsTools/src/bin/auto-console'

    alias run-asterix='bb apollo-pkg && sudo /apollo/bin/runCommand -e WoodchipperAsterixService -a Activate'

    # Fix Java/Scala classpath
    function fcp() {
        # Set mount point so that the classpath is accessible in laptop
        MOUNT_POINT='\/Volumes\/baihqian'
        # Get Scala minor version
        SCALA=`cat Config | egrep -o "^\s*Scala"`
        # Remove all libs and the closing tag
        grep -v '<classpathentry kind=\"lib\"' .classpath | grep -v '</classpath>' > /tmp/classpath
        # Fetch dependencies from Brazil
        if [ $SCALA ]; then
            MINOR_VERSION=`echo $SCALA | egrep -o "[0-9]{2}$" | head -1`
            if [ -z $MINOR_VERSION ]; then
              MINOR_VERSION=10
            fi
            echo "Running brazil-path for Scala2.$MINOR_VERSION"
            BRAZIL_PATH=`(brazil-path testbuild.classpath;\
                        brazil-path build.classpath; \
                        brazil-path build.scalaclasspath.2.$MINOR_VERSION; \
                        brazil-path testrun.scalaclasspath.2.$MINOR_VERSION; \
                        brazil-path testbuild.scalaclasspath.2.$MINOR_VERSION)`
        else
            echo "Running brazil-path for Java"
            BRAZIL_PATH=`(brazil-path testbuild.classpath;\
                        brazil-path build.classpath)`
        fi
        if [ $BRAZIL_PATH ]; then
            echo $BRAZIL_PATH | tr : '\n' | awk '{print "     <classpathentry kind=\"lib\" path=\""$0"\"/>"}' | sort | uniq | \
            sed -e "s/\/opt/\/rhel5pdi/g" | sed -e "s/kind=\"lib\" path=\"/kind=\"lib\" path=\"$MOUNT_POINT/g"\
            >> /tmp/classpath && \
            # Add closing tag
            echo "</classpath>" >> /tmp/classpath && \
            mv /tmp/classpath .classpath && echo "Classpath fixed sucessfully!" 
        else
            echo "Something is wrong - No lib is found!"
        fi
    }

    hash -d ws=/workplace/baihqian

    ## Odin
    urlencode() {
        local length="${#1}"
        for (( i = 1; i <= length; i++ )); do
            local c="${1[i,i]}"
            case $c in
                [a-zA-Z0-9.~_-]) printf "$c" ;;
                *) printf '%%%02X' "'$c"
            esac
        done
    }

    ODIN_BASE="http://localhost:2009/query?Operation=retrieve&ContentType=JSON"

    function getodin_key {
        url="material.materialType=Principal&material.materialName=`urlencode $1`"
        curl "$ODIN_BASE&$url" 2> /dev/null |tr '{},' '\n\n\n' | sed -n 's/"materialData":"\(.*\)"/\1/p' | base64 -di
    }

    function getodin_secret {
        url="material.materialType=Credential&material.materialName=`urlencode $1`"
        curl "$ODIN_BASE&$url" 2> /dev/null |tr '{},' '\n\n\n' | sed -n 's/"materialData":"\(.*\)"/\1/p' | base64 -di
    }

    alias get-password='getodin_secret'

    function odin-kp {
        echo "key:"
        getodin_key $1
        echo "\nsecret:"
        getodin_secret $1
        echo "\n"
    }

    function odin-ak {
        PUBLIC_KEY_URL='http://localhost:2009/query?Operation=retrieve&ContentType=JSON&material.materialName='`urlencode $1`'&material.materialType=PublicKey'
        PRIVATE_KEY_URL='http://localhost:2009/query?Operation=retrieve&ContentType=JSON&material.materialName='`urlencode $1`'&material.materialType=PrivateKey'
        echo "Public Key : " 
        echo `/usr/bin/curl $PUBLIC_KEY_URL  2>&1 | tr '{},' '\n\n\n' | sed -n 's/"materialData":"\(.*\)"/\1/p'`
        echo "\nPrivate Key: "
        echo `/usr/bin/curl $PRIVATE_KEY_URL 2>&1 | tr '{},' '\n\n\n' | sed -n 's/"materialData":"\(.*\)"/\1/p' | base64 -di | /usr/bin/openssl pkcs8 -nocrypt -inform DER`
    }

    # Database alias
    alias mdb-alpha='/apollo/bin/env -e SDETools mysql -h woodchipper-asterix-alpha-baihqian-master.db.amazon.com -P 8443 -u root asterix -p`getodin_secret com.amazon.vpc.credential.db.root.alpha.baihqian`'
    alias mdb-beta='/apollo/bin/env -e SDETools mysql -h asterix-db-pdx-beta.cjfstwomem86.us-west-2.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.beta.pdx`'
    alias mdb-gamma='/apollo/bin/env -e SDETools mysql -h maestro-gamma.c2wopm1cupuo.us-east-1.rds.amazonaws.com -P 8443 -u`getodin_key com.amazon.vpc.maestro.gamma.dbadmin` -p`getodin_secret com.amazon.vpc.maestro.gamma.dbadmin` --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix'
    alias mdb-gru='/apollo/bin/env -e SDETools mysql -h maestro.caqi7qkodqpx.sa-east-1.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.gru`' 
    alias mdb-iad='/apollo/bin/env -e SDETools mysql -h maestro.cwvc9om6avej.us-east-1.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.iad`'
    alias mdb-nrt='/apollo/bin/env -e SDETools mysql -h maestro-2.cjyfwn1haoga.ap-northeast-1.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.nrt`'
    alias mdb-dub='/apollo/bin/env -e SDETools mysql -h maestro.ca2hrbmwct0p.eu-west-1.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.dub`'
    alias mdb-sin='/apollo/bin/env -e SDETools mysql -h maestro.cdrxue6kkimz.ap-southeast-1.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.sin`'
    alias mdb-pdx='/apollo/bin/env -e SDETools mysql -h maestro-2.cs79corchcms.us-west-2.rds.amazonaws.com -P 8200 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.pdx`'
    alias mdb-sfo='/apollo/bin/env -e SDETools mysql -h maestro.cedgh7ze66ur.us-west-1.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.sfo`'
    alias mdb-syd='/apollo/bin/env -e SDETools mysql -h maestro.cbdh2emdityz.ap-southeast-2.rds.amazonaws.com -P 8443 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.syd`'
    alias mdb-fra='/apollo/bin/env -e SDETools mysql -h maestro.cfortws8m1om.eu-central-1.rds.amazonaws.com -P 8200 -u awsixops --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.fra`'
    alias mdb-icn='/apollo/bin/env -e SDETools mysql -h maestro.cpfveliex4ud.ap-northeast-2.rds.amazonaws.com -P 8200 -u awsixops --ssl-ca ~/.ssl/rds-combined-ca-bundle-all-regions.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.icn`'
    alias mdb-bom='/apollo/bin/env -e SDETools mysql -h maestro.caayrmjssfa2.ap-south-1.rds.amazonaws.com -P 8200 -u awsixops --ssl-ca ~/.ssl/rds-combined-ca-bundle-all-regions.pem asterix -p`getodin_secret com.amazon.vpc.credential.db.awsixops.prod.bom`'
    alias mdb-xssroot='/apollo/bin/env -e SDETools mysql -h legacy-20.chzf9mpnq86p.us-west-2.rds.amazonaws.com -P 8200 -u root --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem maestro -pCffqxlCOLIR+C4IYgWbr5A'
    alias mdb-betaroot='/apollo/bin/env -e SDETools mysql -h asterix-db-pdx-beta.cjfstwomem86.us-west-2.rds.amazonaws.com -P 8443 -u root --ssl-ca ~/.ssl/mysql-ssl-ca-cert.pem asterix -p`getodin_secret aws.woodchipper.beta.pdx.asterix.db.root`'

    #Usage example: timberssh iad
    function timberssh() {
        region=$(echo $1 | tr 'a-z' 'A-Z')
        /apollo/env/envImprovement/bin/sshenv -e  TimberFS/$region/Interconnect --ssh 'sshrc'
    }
fi # end of DEVBOX setup

source $ZSH/oh-my-zsh.sh
