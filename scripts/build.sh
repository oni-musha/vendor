#!/bin/bash
# DarkPop Build Script By Cl3Kener

# Fetch Current Path
reldir=`dirname $0`
cd $reldir
DIR=`pwd`

# Colorize Scripts
red=$(tput setaf 1) # red
grn=$(tput setaf 2) # green
cya=$(tput setaf 6) # cyan
pur=$(tput setaf 5) # purple
txtbld=$(tput bold) # Bold
bldred=${txtbld}$(tput setaf 1) # red
bldgrn=${txtbld}$(tput setaf 2) # green
bldblu=${txtbld}$(tput setaf 4) # blue
bldpur=${txtbld}$(tput setaf 5) # purple
bldcya=${txtbld}$(tput setaf 6) # cyan
txtrst=$(tput sgr0) # Reset
DEVICE="$1"
JOBS="$2"

# Clear Scrollback Buffer
echo -e '\0033\0143'
clear

# Make it so EVERY kernel fingerprint is #1
rm -f out/target/product/*/obj/KERNEL_OBJ/.version

#Opticharge
echo -e "${bldpur}Squishing PNGs and JPGs ${txtrst}"
rm -rf device
rm -rf frameworks
rm -rf packages
rm -rf vendor

repo sync $JOBS

cd device
find . -name '*.png' -print0 | xargs -0 -P8 -L1 pngquant --ext .png --force --speed 1
find . -name '*.jpg' -print0 | xargs -0 -P8 -L1 jpegoptim --strip-all
cd ..
cd frameworks
find . -name '*.png' -print0 | xargs -0 -P8 -L1 pngquant --ext .png --force --speed 1
find . -name '*.jpg' -print0 | xargs -0 -P8 -L1 jpegoptim --strip-all
cd ..
cd packages
find . -name '*.png' -print0 | xargs -0 -P8 -L1 pngquant --ext .png --force --speed 1
find . -name '*.jpg' -print0 | xargs -0 -P8 -L1 jpegoptim --strip-all
cd ..
cd vendor
find . -name '*.png' -print0 | xargs -0 -P8 -L1 pngquant --ext .png --force --speed 1
find . -name '*.jpg' -print0 | xargs -0 -P8 -L1 jpegoptim --strip-all
cd ..

# Setup Environment
echo -e "${bldpur}Setting Up Environment ${txtrst}"
. build/envsetup.sh

# Lunch Device
echo -e ""
echo -e "${bldblu}Lunching device ${txtrst}"
lunch "darkpop_$DEVICE-user";

echo -e ""
echo -e "${bldcyn}Compiling DarkPop!!! ${txtrst}"

# Cleanup Out Directory
rm -f out/target/product/$DEVICE/system/build.prop
rm -rf out/target/product/$DEVICE/*.zip

# Start Compilation
make bacon $JOBS
