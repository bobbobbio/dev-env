#!/bin/bash
set -ex

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo apt install -y \
    build-essential \
    toilet \
    cmake \
    gh

# install fish
pushd fish-shell

mkdir build
pushd build

cmake ..
cmake --build .
sudo cmake --install .

popd # build
popd # fish-shell

# install tmux
pushd tmux

sh autogen.sh
./configure
make -j12
sudo make install

popd # tmux

cp .tmux.conf ~/

# install vim
pushd vim
./configure --with-features=huge --enable-pythoninterp
make -j12
sudo make install

popd # vim

cp .vimrc ~/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# other utilities
cargo install cargo-binstall

cargo binstall ripgrep yazi
