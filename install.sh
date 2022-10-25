#!/usr/bin/env bash

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
sudo pacman --noconfirm -S mediainfo   # required for `specs`
sudo pacman --noconfirm -S nano  # for editing code with nanodlv, nanofvid,...
sudo pacman --noconfirm -S openssh # install ssh client and server (sshd command)
sudo pacman --noconfirm -S git # pull in code and updates
sudo pacman --noconfirm -S ncurses # for installing tput, used in fvid
sudo pacman --noconfirm -S moreutils # for fetching the current IP address
sudo pacman --noconfirm -S python
sudo pacman --noconfirm -S ffmpeg
sudo pacman --noconfirm -S jq

echo "installing Python packages..."
pip install -U pip
pip install -U wheel
pip install -U yt-dlp
pip install -U requests
pip install -U selenium
pip install -U beautifulsoup4
pip install -U image
pip install -U pillow
pip install -U facebook-scraper
pip install -U snscrape
pip install -U pywebcopy

echo "installing VidHop..."
vidhop_app_dir="/opt/vidhop"        # $PREFIX points to /data/data/com.termux/files/usr
loader="$vidhop_app_dir/bin/loader" # loader in /opt/vidhop
loader_bin="/usr/local/bin/vidhop"  # loader in /bin

if [ -d "$vidhop_app_dir" ]; then
  echo -n "$vidhop_app_dir already existis, remove it? Y/n: " && read answer && answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
  [ "$answer" = "y" ] || [ -z "$answer" ] && unset answer &&
    rm -rf "$vidhop_app_dir" && sleep 3 &&
    git clone https://github.com/wtechgo/vidhop-linux.git "$vidhop_app_dir"
else
  git clone https://github.com/wtechgo/vidhop-linux.git "$vidhop_app_dir"
fi
chmod +x "$vidhop_app_dir/install.sh"
chmod +x "$loader"

sudo cp "$loader" "$loader_bin" # copy loader to /bin as 'vidhop' to , load VidHop with command 'source vidhop`
echo -e "\n. vidhop" >>"$HOME/.bashrc"
. vidhop # loads vidhop by sourcing $PREFIX/bin/vidhop ## only works when they source install.sh
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
