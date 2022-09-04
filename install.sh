#!/usr/bin/env bash
set -euo pipefail

BLUE='\e[34m'
GREEN='\e[32m'
NC='\e[0m'

echo -e "\nHi, This is the VidHop install script.\n"
echo -e "It will install all required packages and libraries to run VidHop."
echo -e "An overview of what this script does:"
echo -e "    1. install required packages from Linux repositories"
echo -e "    2. install Python"
echo -e "    3. install yt-dlp (written in Python)"
echo -e "    4. install VidHop, includes JQ (library for managing JSON metadata) and Python libs for scraping channel avatar images"
echo -e "\n${BLUE}Requirements:${NC}"
echo -e "    2. A working internet connection.\n"
echo -e "ATTENTION: This script is written for Arch like distros.n"
echo -e "           Modify the script accordingly if you have another distro.\n"
echo -n "When you are ready, press enter: " && read


echo "installing required packages from Linux repositories..."
# mediainfo nano openssh git ncurses moreutils python python-pip ffmpeg jq
sudo pacman -S install mediainfo   # required for `specs`
sudo pacman -S install nano  # for editing code with nanodlv, nanofvid,...
sudo pacman -S install openssh # install ssh client and server (sshd command)
sudo pacman -S install git # pull in code and updates
sudo pacman -S install ncurses # for installing tput, used in fvid
sudo pacman -S install moreutils # for fetching the current IP address
sudo pacman -S install python ffmpeg


echo "installing yt-dlp packages..."
pip install -U pip
pip install -U wheel
pip install -U yt-dlp


echo "installing VidHop packages..."
pkg install jq
pip install -U requests
pip install -U selenium
pip install -U beautifulsoup4
pip install -U image
pip install -U pillow


echo "installing VidHop..."
vidhop_app_dir="/opt/vidhop" # $PREFIX points to /data/data/com.termux/files/usr
loader="$vidhop_app_dir/bin/loader" # loader in /opt/vidhop
loader_bin="/usr/local/bin/vidhop" # loader in /bin

git clone https://github.com/wtechgo/vidhop-android.git "$vidhop_app_dir"

chmod +x "$loader"
cp "$loader" "$loader_bin"  # copy loader to /bin as 'vidhop' to enable running `source vidhop`
echo -e "\n. vidhop >> $HOME/.bashrc"
. vidhop  # loads vidhop by sourcing $PREFIX/bin/vidhop ## only works when they source install.sh
cd "$vidhop_dir"

echo -e "\nExtra information:\n"
echo -e "Installation added a line to .bashrc to load VidHop in each terminal which is recommended."
echo -e "It won't bog down terminal load times as VidHop is extremely lightweight."
echo -e "The app only defines functions and variables: work only happens when YOU run a functions.\n"

echo -e "In case you don't like that, remove this line:\n  . vidhop"
echo -e "from .bashrc at:\n  $HOME/.bashrc"
echo -e "with shortucut:\n  nanobashrc\n"

echo -e "You can still load VidHop manually with commands:"
echo -e "  source vidhop" && echo "  . vidhop"
sleep 3

echo -e "\n${GREEN}VidHop installed ! ${NC}\n" && sleep 1

echo -n "Print output of all help functions? y/N: " && read -r answer
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
[ "$answer" = "y" ] && vidhophelp
