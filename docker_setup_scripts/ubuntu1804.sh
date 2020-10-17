#!/usr/bin/env bash

set -euo pipefail

echo "::group::apt update"
apt-get update
apt-get dist-upgrade -y
echo "::endgroup::"

packages=(
    apt-file
    apt-utils
    automake
    bison
    curl
    flex
    git
    golang
    less
    libbz2-dev
    libicu-dev
    libncurses5-dev
    libreadline-dev
    libssl-dev
    libtool
    libunwind-dev
    locales
    maven
    openjdk-8-jdk-headless
    pkg-config
    python-dev
    python-pip
    python3-dev
    python3-pip
    python3-venv
    python3-wheel
    rsync
    sudo
    unzip
    uuid-dev
    vim
    wget
    xz-utils
)

echo "::group::Installing Ubuntu packages"
apt-get install -y "${packages[@]}"
echo "::endgroup::"

echo "::group::Installing LLVM/Clang packages"
bash /tmp/yb_docker_setup_scripts/ubuntu_install_llvm_packages.sh
echo "::endgroup::"

echo "::group::apt cleanup"
apt-get -y clean
apt-get -y autoremove
echo "::endgroup::"

locale-gen en_US.UTF-8

bash /tmp/yb_docker_setup_scripts/perform_common_setup.sh

rm -rf /tmp/yb_docker_setup_scripts
