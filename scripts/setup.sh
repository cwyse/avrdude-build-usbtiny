#!/usr/bin/env bash

#
# setup.sh
#
# This script checks for the required
# Linux packages to run or build avrdude.
#
# USAGE: ./setup.sh [build]
#   If the build parameter is specified, all
#   packages required to rebuild avrdude will
#   be installed.
#
set -e

if [ "$1" == "build" ]; then
  BUILD=1
else
  BUILD=0
fi

echo "============================================="
echo " Avrdude support package installation script
echo "============================================="
echo


if [ ${BUILD} -eq 1 ]; then
  echo "Installing all packages necessary for building."
  echo
  required_packages="  build-essential bison subversion zip"
  required_packages+=" automake flex pkg-config libftdi1-dev"
  required_packages+=" libtool libelf-dev wget"
else
  echo "Installing run-time packages."
  echo
  required_packages+=" libftdi1 libelf "
fi  

missing=
for pkg in required_packages; do
  if ! dpkg -s $pkg > /dev/null; then
    missing+="$pkg "
  fi
done

function version_gt() 
{ 
  test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; 
}

if [ -z "${missing}" ]; then
  echo "The following packages have not been installed:"
  echo "  $missing"
  echo
  if ! dpkg -s libftdi1-dev >/dev/null; then
    . /etc/lsb-release
    if ! version_gt ${DISTRIB_RELEASE} "16.04" ]; then
      echo
      echo "The libftdi1-dev package is available in the"
      echo "Ubuntu 16.04 package repositories.  You either"
      echo "need to install/build the package manually, or"
      echo "upgrade to at least Ubuntu 16.04."
      echo
      exit 1
    fi
  fi

  echo "These packages will be installed with the following"
  echo "command:"
  echo "  sudo apt-get --assume-yes install ${missing}"
  echo
  echo "Enter your password to start installation."
  echo
  sudo apt-get --assume-yes install ${missing}

fi

echo 
echo "============================================="
echo " Installation completed successfully
echo "============================================="

exit 0
