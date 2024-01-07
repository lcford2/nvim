#!/bin/bash

# ubuntu deps ninja-build gettext cmake unzip curl git gcc
# macos xcode-select --install, brew, ninja, cmake, gettext, curl

MAJOR_TARGET=9
MINOR_TARGET=5
VERSION="v0.${MAJOR_TARGET}.${MINOR_TARGET}"
BASE_URL="https://github.com/neovim/neovim/releases/download/${VERSION}"
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

ARCH=$(uname -m)
OS=$(uname)

if [ -z "${PREFIX}" ]; then
  PREFIX=/usr/local
fi

INSTALL=1
UPGRADE=0

usage () {
  echo "usage:"
  echo "./install.sh [-h|--help] [-n|--no-install] [-U|--upgrade]"
  echo "Arguments:"
  echo "    -h|--help:       Display this help message and quit."
  echo "    -n|--no-install: Do not attempt to install neovim"
  echo "                     User must have neovim installed already"
  echo "    -U|--upgrade:    Upgrade Neovim to latest version."
}

neovim_install_help() {
  echo "See https://github.com/neovim/neovim/blob/master/INSTALL.md"
  echo "for installation instructions."
}

_install_binary () {
  echo "INTALLING FROM BINARY"
  if [ $# -lt 1 ]; then
    echo "Must provide binary name."
    exit 3
  fi
  binary_name="$1"
  URL="${BASE_URL}/${binary_name}.tar.gz"
  echo "$URL"
  curl -sOL "$URL"
  tar xf "${binary_name}.tar.gz"
  mkdir -p "${PREFIX}/{bin,share,lib,man}"
  cp -r "${binary_name}/bin/nvim" "${PREFIX}/bin/nvim"
  cp -r "${binary_name}/share/"* "${PREFIX}/share"
  cp -r "${binary_name}/lib/"* "${PREFIX}/lib"
  cp -r "${binary_name}/man/"* "${PREFIX}/man"
  rm -rf "./${binary_name}" "./${binary_name}.tar.gz"
}

_install_source () {
  echo "INTALLING FROM SOURCE"
  curl -sOL "https://github.com/neovim/neovim/archive/refs/tags/${VERSION}.tar.gz"
  tar xf "${VERSION}.tar.gz"
  cd "neovim-0.${MAJOR_TARGET}.${MINOR_TARGET}"
  make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX"
  make install || \
    echo "ERROR: Could not run 'make install' for neovim." \
         " This is likely due to permission errors. Try running " \
         " with sudo."
}

install_nvim () {
  if [ "${OS}" == "Linux" ]; then
    if [ "${ARCH}" != "amd64" ]; then
      _install_source
      # echo "Cannot install pre-compiled binaries for arm64 on Linux."
      # echo "Download source code and compile Neovim from source."
      # neovim_install_help
      # exit 1
    else 
      # Install neovim from latest stable release
      _install_binary "nvim-linux64"
    fi
  elif [ "${OS}" == "Darwin" ]; then
    if command -v brew &>/dev/null; then
      brew install neovim
    else
      _install_binary "nvim-macos"
    fi
  fi
}

while test $# -gt 0; do
  case "$1" in
    -n|--no-install)
      echo "Not attempting to install neovim"
      INSTALL=0
      ;;
    -U|--upgrade)
      echo "Upgrading neovim."
      UPGRADE=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
  esac
  shift
done

echo "Installing with configuration:"
echo "Neovim Version: $VERSION"
echo "ARCH: ${ARCH}"
echo "OS: ${OS}"
echo "PREFIX: ${PREFIX}"

if ! command -v nvim &> /dev/null; then
  if [ "$INSTALL" == 0 ]; then
    echo "Neovim was not found and no install attempt was made."
    echo "Please install neovim with your preferred method."
    neovim_install_help
    exit 1
  fi
  install_nvim 
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
  mkdir -p ~/.config
  XDG_CONFIG_HOME="${HOME}/.config"
fi

NVIM_DIR="${XDG_CONFIG_HOME}/nvim"

if [ -d "${NVIM_DIR}" ]; then
  mv "${NVIM_DIR}" "${NVIM_DIR}.bkp"
fi

mkdir -p "${NVIM_DIR}"
curl -sOL 


