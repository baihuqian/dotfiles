# Automatically run kinit if credentials are outdated
alias checkkinit="if ! klist -s; then kinit -f; fi &&"
alias bb="checkkinit brazil-build"
alias pr="checkkinit post-review"
alias git="checkkinit git"
alias bbcr="bb clean && bb release"


## Create workspace and download the package
function createws() {
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
alias syncvs="brazil ws sync --md"
