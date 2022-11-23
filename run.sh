#!/bin/bash

cd "`dirname $0`"

add_if_not_present() {
  if !(grep -q "$1" $2); then
    echo "$1" >> $2
  fi
}

touch ~/.zshrc
touch ~/.zsh_aliases
add_if_not_present 'source ~/.zsh_aliases' "$HOME/.zshrc"

# Check for Darwin
if [[ "$(uname -s)" != "Darwin" ]];
then
  echo "This script should only be run on a Mac OS (based on Darwin)"
  exit 1
fi

# Validate ZSH is default shell
SHELL_LOCATION='/bin/zsh'

if [[ "$SHELL" != "$SHELL_LOCATION" ]];
then
  echo "zsh (located at $SHELL_LOCATION) must be your default shell to continue"
  echo "Set zsh as your default shell? (y/n)"
  read DefaultZsh
  if [ "$DefaultZsh" == "y" ];
  then
    if ! [ -f "$SHELL_LOCATION" ];
    then
      echo "$SHELL_LOCATION does not exist. Make sure zsh is installed at $SHELL_LOCATION"
      exit 1
    fi
    if ! grep -Fxq "$SHELL_LOCATION" /etc/shells ;
      then
        echo "You must have $SHELL_LOCATION as a default login shell in /etc/shells. Add it now to continue (sudo required)? (y/n)"
        read DefaultZshShell
        if [ "$DefaultZshShell" == "y" ];
          then
            echo "$SHELL_LOCATION" | sudo tee -a /etc/shells
          else
            echo "Exiting Process."
            exit 1
        fi
    fi
    echo "Setting $SHELL_LOCATION as your default shell. You will need to provide sudo privledges for this."
    chsh -s $SHELL_LOCATION
    echo "Reloading your terminal to account for changes and continuing where you left off"
    $SHELL_LOCATION
  else
    echo "Exiting Process."
    exit 1
  fi
fi

CURRENT_ARCHITECTURE="$(uname -m)"
if [[ "$CURRENT_ARCHITECTURE" == "x86_64" ]]
then
  BREW_BIN="/usr/local/bin"
elif [[ "$CURRENT_ARCHITECTURE" == "arm64" ]]
then
  BREW_BIN="/opt/homebrew/bin"
else
  echo "This script can only be run on one of the supported architectures ($SUPPORTED_ARCHITECTURES) but you are using ($CURRENT_ARCHITECTURE)."
  exit 1
fi
PATH=$BREW_BIN:$PATH
BREW_LOCATION="$BREW_BIN/brew"

if [ "$(which brew)" != "$BREW_LOCATION" ];
then
  printf "Brew not found at $BREW_LOCATION (for the architecture $CURRENT_ARCHITECTURE). Install it there to continue.\nInstall Brew at $BREW_LOCATION? (y/n)\n"
  read Brew
  if [ "$Brew" == "y" ];
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "\$($BREW_LOCATION shellenv)"
    add_if_not_present "eval \"\$($BREW_LOCATION shellenv)\"" "~/.zshrc"
  else
    echo "Exiting Process."
    exit 1
  fi
fi


echo ""
echo "Setup Choices:"
echo "=============="

echo "Use a color prompt? (y/n)"
read ColorPrompt

echo "Setup helpful aliases for ls and other terminal features? (y/n)"
read UseAliases

echo "Generate Git Credentials? (y/n)"
read Git

echo "Install Python 3 (with brew)? (y/n)"
read Py3

echo "Setup Node (NVM, Node v14 via NVM, NPM via NVM, and Yarn via NPM)? (y/n)"
read NodeJS

echo "Allow remote access to this machine? (y/n)"
read Remote

echo "=============="
echo "Are all above Selections Correct? (y/n)"
read Correct

echo "=============="
if [ "$Correct" == "y" ];
then
  echo "========="
  if [ "$ColorPrompt" == "y" ];
  then
    echo "Enabling Color Prompt"
    add_if_not_present 'autoload -U colors && colors' "$HOME/.zshrc"
    add_if_not_present 'PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[yellow]%}%~ %{$reset_color%}$ "' "$HOME/.zshrc"
    echo "========="
  fi
  if [ "$UseAliases" == "y" ];
  then
    echo "Enabling Color Prompt"
    add_if_not_present "alias ls='ls -G'" "$HOME/.zsh_aliases"
    add_if_not_present "alias ll='ls -alF'" "$HOME/.zsh_aliases"
    add_if_not_present "alias la='ls -A'" "$HOME/.zsh_aliases"
    add_if_not_present "alias l='ls -CF'" "$HOME/.zsh_aliases"
    add_if_not_present "alias whereis='which -a'" "$HOME/.zsh_aliases"
    echo "========="
  fi
  if [ "$Git" == "y" ];
  then
    git_credential() {
      echo "Running Git Credential Setup."
      echo "Make sure you did not run this command as as super user (su, sudo)"
      echo ""
      echo "Did you run this script as root? (y/n)"
      read superuser

      if [ "$superuser" == "n" ];
      then
        echo "Continuing with Git Setup"
      else
        echo "Ending Setup. Run command as a normal user."
        exit 1
      fi

      echo "What is your email for git?"
      read email1
      echo "Please retype your email for git."
      read email2

      if [ $email1 == $email2 ];
      then
        echo "Emails Match. Generating a git ID"
      else
        echo "Emails do not match. Restarting git credential creation process."
        git_credential
        exit 1
      fi

      ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C $email1
    }
    echo "To use your git credentials, you need to copy your public key(s)"
    echo "over to github in your personal section under the ssh tab."
    echo "These keys can be found in ~/.ssh"
    echo "========="
  fi
  if [ "$Py3" == "y" ];
  then
    install_py3() {
      echo "Installing python3.10"
      brew install python@3.10
      echo "Upgrading pip for python3.10"
      curl -sS https://bootstrap.pypa.io/get-pip.py | $BREW_LOCATION/python3.10
      echo "Installing virtualenv for python3.10"
      $BREW_LOCATION/python3.10 -m pip install virtualenv || true
      echo "Adding Quick Access to make and activate virtualenvs as makevenv and vact"
      add_if_not_present '# Quick Access to build and activate virtualenvs' "$HOME/.zsh_aliases"
      add_if_not_present 'alias makevenv="python3 -m virtualenv venv && vact"' "$HOME/.zsh_aliases"
      add_if_not_present 'alias vact="deactivate  > /dev/null 2>&1; source venv/bin/activate"' "$HOME/.zsh_aliases"
    }

    if [[ "$(which -a python3.10)" != "" ]]; then
      echo "Python3.10 is already installed in the following locations:"
      printf "$(which -a python3.10)\n"
      echo "This will install Python3.10 with Brew for $HOSTNAME ($(uname -m)) at $BREW_LOCATION"
      echo "Are you sure? (y/n)"
      read ays_python
      if [[ "$ays_python" == "y" ]]; then
        install_py3
      else
        echo "Not installing python3"
      fi
    else
      install_py3
    fi
    echo "========="
  fi
  if [ "$NodeJS" == "y" ];
  then
    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    add_if_not_present 'export NVM_DIR="$HOME/.nvm"' "$HOME/.zshrc"
    add_if_not_present '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'  "$HOME/.zshrc"
    add_if_not_present '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'  "$HOME/.zshrc"
    echo "NVM Install Complete"
    echo "Installing most recent version of Node 14 and NPM"
    nvm install v14
    echo "Node and NPM Install Complete"
    echo "Installing Yarn"
    npm install --global yarn
    echo "Yarn install complete"
    echo "========="
  fi
  if [ "$Remote" == "y" ];
  then
    echo "Enabling Remote Login"
    sudo systemsetup -setremotelogin on
    echo "========="
  fi
  echo "Macqs process complete!"
  exit 1
else
  echo "Restarting Process."
  ./run.sh
  exit 1
fi
