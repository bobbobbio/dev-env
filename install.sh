#!/bin/bash
set -ex

if ! test -f ~/.cargo/bin/rustc; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

sudo apt install -y \
    automake \
    build-essential \
    toilet \
    cmake \
    gh \
    libevent-dev

# install fish
if ! test -f /usr/local/bin/fish; then
    pushd fish-shell

    mkdir build
    pushd build

    cmake ..
    cmake --build .
    sudo cmake --install .

    popd # build
    popd # fish-shell

    mkdir -p ~/.config
    cp -r .config/fish ~/.config/
    cp -r themes/catppuccin/fish/themes ~/.config/fish/

    sudo bash -c "echo /usr/local/bin/fish >> /etc/shells"
    chsh --shell /usr/local/bin/fish
fi

# install tmux
if ! test -f /usr/local/bin/tmux; then
    pushd tmux

    sh autogen.sh
    ./configure
    make -j12
    sudo make install

    popd # tmux

    cp .tmux.conf ~/
fi

# install vim
if ! test -f /usr/local/bin/vim; then
    pushd vim
    ./configure --with-features=huge --enable-pythoninterp
    make -j12
    sudo make install

    popd # vim

    cp .vimrc ~/
    mkdir -p ~/.vim
    cp -r themes/catppuccin/vim/colors ~/.vim/

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    cp -r themes/catppuccin/vim/autoload/lightline/colorscheme ~/.vim/bundle/lightline.vim/autoload/lightline/
fi



# other utilities
cargo install cargo-binstall

cargo binstall ripgrep

# todo: yazi
