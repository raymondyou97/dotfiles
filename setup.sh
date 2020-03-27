#!/bin/bash

help="Installs my personal configs on a new work station
Usage: $0
    -h : Help
    -a : Installs all librarys/dependencies
    -v : Configures vim
    -z : Configures zsh
"

if [[ "$#" -lt 1 ]]; then
    echo "ERROR: Must supply an option for script. -h for options"
    exit
fi

install() {
    # install zsh
    sudo apt install zsh

    # install curl, git, tmux, wget (in case not installed)
    sudo apt update
    sudo apt upgrade
    sudo apt install curl git tmux wget

    # install oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # install cmake, vim, python
    sudo apt install build-essential cmake vim python3 python3-dev

    # install mono-complete
    sudo apt update
    sudo apt install dirmngr gnupg apt-transport-https ca-certificates
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    sudo sh -c 'echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" > /etc/apt/sources.list.d/mono-official-stable.list'
    sudo apt update
    sudo apt install mono-complete

    # install go
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt update
    sudo apt install golang-go

    # install node and npm
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install nodejs

    # install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # install rg
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
    rm ~/dotfiles/ripgrep*

    # install bat
    wget https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_amd64.deb
    sudo dpkg -i bat*
    rm -f bat*
}

setup_vim() {
    # symlink
    ln -fs ~/dotfiles/vimrc ~/.vimrc

    # vim color scheme
    mkdir -p ~/.vim/colors/
    wget http://bitbucket.org/sjl/badwolf/raw/tip/colors/badwolf.vim -P ~/.vim/colors/

    # set up vundle and install plugins
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    # setup YCM
    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all
}

setup_zshrc() {
    # symlink
    ln -fs ~/dotfiles/zshrc ~/.zshrc
}

while getopts ":havz" opt; do
    case ${opt} in
        h ) 
            echo "$help"
            ;;
        a )
            install
            ;;
        v )
            setup_vim
            ;;
        z )
            setup_zshrc
            ;;
        \? ) 
            echo "ERROR: Option not supported. -h for options"
            ;;
    esac
    shift
done
