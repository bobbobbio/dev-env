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

# install tmux

# install vim

# other utilities
cargo install cargo-binstall

cargo binstall ripgrep yazi
