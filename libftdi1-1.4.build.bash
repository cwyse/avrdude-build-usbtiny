#!/bin/bash -ex
# Copyright (c) 2014-2016 Arduino LLC
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

mkdir -p objdir
cd objdir
PREFIX=`pwd`
cd -

if [[ ! -f libftdi1-1.4.tar.bz2  ]] ;
then
	wget http://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.4.tar.bz2
fi

tar xfv libftdi1-1.4.tar.bz2

cd libftdi1-1.4
cmake -DCMAKE_INSTALL_PREFIX=PATH=$PREFIX -DCMAKE_PREFIX_PATH="${PREFIX}/lib/pkgconfig" .
if [[ $CROSS_COMPILE != "" ]] ; then
  echo "No support added or tested for cross-compiling libftdi1."
  exit 1
fi
make all
make install
cd ..

