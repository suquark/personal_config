echo "Configuring tmux..."

# tmux
cat <<EOT > ~/.tmux.conf
# remap prefix to Control + a
set -g prefix C-a
# bind 'C-a C-a' to type 'C-a'
bind C-a send-prefix
unbind C-b
EOT
tmux source-file ~/.tmux.conf

echo "Installing oh-my-zsh..."

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Installing vimrc..."

# vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

echo "Installing Unix command line tools..."

# from https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    declare -A osInfo;
    osInfo[/etc/redhat-release]=yum
    osInfo[/etc/arch-release]=pacman
    osInfo[/etc/gentoo-release]=emerge
    osInfo[/etc/SuSE-release]=zypp
    osInfo[/etc/debian_version]=apt-get

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            echo Package manager: ${osInfo[$f]}
            ${osInfo[$f]} install -y wget curl git ncdu htop tmux vim
        fi
    done
    # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    brew install wget curl git ncdu htop tmux vim
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
else
    # Unknown.
fi