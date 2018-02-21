# RHEL specific commands

INSTALL="sudo yum -y install"
GET="curl -LO"
RM="rm"
LINK="ln -sfv"
PIP_INSTALL="sudo pip install"

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA_DIR="$HOME/.extra"

source $DOTFILES_DIR/config.sh

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" submodule update --init

$LINK "$DOTFILES_DIR/git/.gitconfig" ~

# RHEL
$GET https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
$INSTALL ./epel-release-latest-*.noarch.rpm
$RM ./epel-release-latest-*.noarch.rpm

# Tmux
$INSTALL tmux
$LINK "$DOTFILES_DIR/tmux/.tmux.conf" ~

# Vim
$INSTALL vim
$LINK "$DOTFILES_DIR/vim" ~/.vim

# ZSH setup
$INSTALL zsh zsh-completions
$LINK "$DOTFILES_DIR/zsh/.zshrc" ~
$LINK "$DOTFILES_DIR/oh-my-zsh" ~/.oh-my-zsh
chsh -s /bin/zsh

# Python
$INSTALL python python3
$INSTALL python-setuptools python-pip python-wheel
$PIP_INSTALL jedi ropevim awscli

# Go
$GET https://storage.googleapis.com/golang/${GO_BINARY_PATH}
sudo tar -C /usr/local -xzf ${GO_BINARY_PATH}
echo "export PATH=\$PATH:/usr/local/go/bin" | tee -a ~/.profile
$RM ${GO_BINARY_PATH}


# Install extra stuff

if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
    . "$EXTRA_DIR/install.sh"
fi
