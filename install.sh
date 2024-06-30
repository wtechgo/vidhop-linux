#!/usr/bin/env bash

BLUE='\e[34m'
GREEN='\e[32m'
NC='\e[0m'

echo -e "\nHi, This is the VidHop install script."
echo -e "It will install all required packages and libraries to run VidHop.\n"
echo -e "${BLUE}Overview${NC} of what this script does:"
echo -e "    1. install required packages from Linux repositories"
echo -e "    2. install Python"
echo -e "    3. install yt-dlp (video downloader library written in Python)"
echo -e "    4. install VidHop"
echo -e "       - binaries in /opt/vidhop (shell scripts)"
echo -e "       - add a shortcut to VidHop loader in /usr/local/vidhop (enables calling . vidhop)"
echo -e "       - add 1 line to your shell rc to load VidHop on opening a terminal"
echo -e "\n${BLUE}Requirements:${NC}"
echo -e "    A working internet connection.\n"
echo -e "${BLUE}Attention${NC}:"
echo -e "    This script is written for Arch like Linux distros, meaning,"
echo -e "    the script uses pacman as package manager."
echo -e ""
echo -e "    If your distro is Ubuntu for example, you need to replace"
echo -e "    all 'pacman -S' commands with 'apt install' commands in install.sh,"
echo -e "    save the file and execute install.sh again."
echo -e ""
echo -e "    If that's the case, do this:"
echo -e "    - CTRL-C (to abort this script)"
echo -e "    - nano install.sh (to edit the text)"
echo -e "    - make the changes, replace 'pacman' with your package manager"
echo -e "    - CTRL-X (close the document), hit y & ENTER (to save before closing nano)"
echo -e "    - ./install.sh (to run install.sh again)"
echo -e ""
echo -n "When you are ready, press ENTER to continue, or CTRL-C to abort: " && read

echo "installing required packages from Linux repositories..."
sudo pacman --noconfirm -S mediainfo   # required for `specs`
sudo pacman --noconfirm -S imagemagick # convert images
sudo pacman --noconfirm -S nano  # for editing code with nanodlv, nanofvid,...
sudo pacman --noconfirm -S openssh # install ssh client and server (sshd command)
sudo pacman --noconfirm -S git # pull in code and updates
sudo pacman --noconfirm -S ncurses # for installing tput, used in fvid
sudo pacman --noconfirm -S moreutils # for fetching the current IP address
sudo pacman --noconfirm -S python
sudo pacman --noconfirm -S ffmpeg
sudo pacman --noconfirm -S jq

echo "installing Python packages..."
# https://peps.python.org/pep-0668/?ref=itsfoss.com
#sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED # enable break
#sudo touch /usr/lib/python3.11/EXTERNALLY-MANAGED # disable break
pip install --break-system-packages -U pip
pip install --break-system-packages -U wheel
pip install --break-system-packages -U yt-dlp
pip install --break-system-packages -U requests
pip install --break-system-packages -U selenium
pip install --break-system-packages -U beautifulsoup4
pip install --break-system-packages -U image
pip install --break-system-packages -U pillow

#yes | pip uninstall --break-system-packages wheel
#yes | pip uninstall --break-system-packages yt-dlp
#yes | pip uninstall --break-system-packages requests
#yes | pip uninstall --break-system-packages selenium
#yes | pip uninstall --break-system-packages beautifulsoup4
#yes | pip uninstall --break-system-packages image
#yes | pip uninstall --break-system-packages pillow

## Create and use a venv for VidHop.
## https://peps.python.org/pep-0668/?ref=itsfoss.com
#echo "installing Python packages..."
#python -m venv /opt/vidhop/bin/.env-python
#source /opt/vidhop/bin/.env-python/bin/activate
#/opt/vidhop/bin/.env-python/bin/python -m pip install --upgrade pip
#/opt/vidhop/bin/.env-python/bin/pip install yt-dlp
#/opt/vidhop/bin/.env-python/bin/pip install requests
#/opt/vidhop/bin/.env-python/bin/pip install selenium
#/opt/vidhop/bin/.env-python/bin/pip install beautifulsoup4
#/opt/vidhop/bin/.env-python/bin/pip install image
#/opt/vidhop/bin/.env-python/bin/pip install pillow
## Ignore venv system: sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED
## Revert venv system: sudo touch /usr/lib/python3.11/EXTERNALLY-MANAGED

echo "installing VidHop..."
vidhop_app_dir="/opt/vidhop"        # $PREFIX points to /data/data/com.termux/files/usr
loader="$vidhop_app_dir/bin/loader" # loader in /opt/vidhop
loader_bin="/usr/local/bin/vidhop"  # loader in /bin
shell_rc="$(echo $SHELL | sed "s#/bin/#$HOME/.#g")"

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
echo -e "\n. vidhop" >>"$shell_rc"
. vidhop # loads vidhop by sourcing $PREFIX/bin/vidhop ## only works when they source install.sh
cd "$vidhop_dir"

echo -e "\nExtra information:\n"
echo -e "Installation added a line to .bashrc to load VidHop in each terminal which is recommended."
echo -e "It won't bog down terminal load times as VidHop is extremely lightweight."
echo -e "The app only defines functions and variables: work only happens when YOU run a functions.\n"

echo -e "In case you don't like that, remove this line:"
echo -e ". vidhop"
echo -e "from your .rc file at: $shell_rc"
echo -e "with shortucut:\n  nanobashrc\n"

echo -e "You can still load VidHop manually with commands:"
echo -e "  source vidhop" && echo "  . vidhop"
sleep 3

echo -e "\n${GREEN}VidHop installed ! ${NC}\n" && sleep 1

echo -n "Print output of all help functions? y/N: " && read -r answer
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
[ "$answer" = "y" ] && vidhophelp
