## avrdude build scripts for Arduino/Genuino 

### **** This fork adds support for 128KB flash reads via USBTinyISP, and changes to include libftdi1 support.  These changes are only supported on Linux. ****

The original repository has been modified in the following ways:
  1. Only Linux (Ubuntu 16.04) support has been tested
  2. Shared libraries are used instead of static
  3. Setup script added to install necessary packages
  4. avrdude source has been patched to support 128K reads
  5. Firmware backup script for Prusa-i3 added
  6. The binary tar.bz2 file for Linux has been included
  7. The original firmware files from the Prusa-i3 have been added

To clone original repository:  
  git clone https://github.com/arduino/avrdude-build-script.git

To clone this repository:
  git clone git@github.com:cwyse/avrdude-build-usbtiny.git

The text below this point is from the original repository, with
some minor updates.

################################################################

This is the build script for the avrdude tool used in the [Arduino IDE](http://arduino.cc/).

The latest version available is 6.3.

As soon as [avrdude ships a new version](http://www.nongnu.org/avrdude/), we pull the source code, **patch it** with some user contributed patches and deliver it with the [Arduino IDE](http://arduino.cc/).
Therefore, the resulting binaries may differ significantly from upstream, you should start blaming us if things are not working as expected :)

### Building

Just run:

```
./package-avrdude.bash
```

Setup has been done on partially set up development machines.
If you find any package missing from the following list, please open an issue at once!

#### Debian requirements

You need to be running at least Ubuntu 16.04, since its repository
provides libftdi1 & libftdi1-dev.

```bash
sudo apt-get install build-essential bison subversion zip automake flex pkg-config libftdi1-dev libtool libelf-dev wget
```

#### Mac OSX requirements

You need to install MacPorts: https://www.macports.org/install.php. Once done, open a terminal and type:

```bash
sudo port selfupdate
sudo port upgrade outdated
sudo port install wget +universal
sudo port install automake +universal
sudo port install autoconf +universal
sudo port install gpatch +universal
sudo port install libusb +universal
```

#### Windows cross-compile from Linux requirements

```bash
sudo apt-get install gcc-mingw-w64-i686
```

When building you must set the env var `CROSS_COMPILE` to `mingw` for example:

```
CROSS_COMPILE=mingw ./package_avrdude.bash
```

cross compile with mingw has been tested on Ubuntu 14.04 (mingw-w64 4.8), different versions of mingw may behave differently and fail to build.

#### Windows requirements

**WARNING: the script for native Cygwin or Mingw builds has been started and abandoned in favor of cross
compile with mingw (see section above). Please consider this part of the build script as a best effort
bonus (it may work as it may, very probably, not work).**

You need to install Cygwin: http://www.cygwin.com/. Once you have run `setup-x86.exe`, use the `Search` text field to filter and select for installation the following packages:

- git
- wget
- unzip
- zip
- bison
- flex
- make
- patch
- automake
- autoconf
- gcc-g++

You also need to install MinGW: http://www.mingw.org/. Once you have run mingw-get-setup.exe, select and install (clicking on "Installation" -> "Apply changes") the following packages:

- mingw-developer-toolkit
- mingw32-base
- mingw32-gcc-g++
- msys-base
- msys-zip

### Upstream credits

Build process ported from Debian. Thank you guys for your awesome work.

### Credits

Consult the list of contributors [here](https://github.com/arduino/avrdude-build-scripts/graphs/contributors) and [here](https://github.com/arduino/toolchain-avr/graphs/contributors).

### License

The bash scripts are GPLv2 licensed. Every other software used by these bash scripts has its own license. Consult them to know the terms.

