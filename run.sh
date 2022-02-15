#!/bin/bash

cd "`dirname $0`"

# Check for Darwin
if [[ "$(uname -s)" != "Darwin" ]];
then
  echo "This script should only be run on a Mac OS (based on Darwin)"
  exit 1
fi

SUPPORTED_ARCHITECTURES="arm64 or x86_64"

# Validate current architecture is supported
CURRENT_ARCHITECTURE="$(uname -m)"
if [[ "$CURRENT_ARCHITECTURE" == "x86_64" ]]
then
  BREW_BIN="/usr/local/bin"
elif [[ "$CURRENT_ARCHITECTURE" == "arm64" ]]
then
  BREW_BIN="/opt/homebrew/bin"
  PATH=$BREW_BIN:$PATH
else
  echo "This script can only be run on one of the supported architectures ($SUPPORTED_ARCHITECTURES) but you are using ($CURRENT_ARCHITECTURE)."
  echo "You should consider using rosetta as a translation layer."
  echo "See the macqs docs on how to setup a rosetta terminal."
  exit 1
fi

BASH_LOCATION="/bin/bash"
BREW_LOCATION="$BREW_BIN/brew"

if [ "$(which bash)" != "$BASH_LOCATION" ];
then
  echo "Bash must be installed at $BASH_LOCATION to continue."
  exit 1
fi

if [ "$(which brew)" != "$BREW_LOCATION" ];
then
  printf "Brew not found at $BREW_LOCATION (for the architecture $CURRENT_ARCHITECTURE). Install it there to continue.\nInstall Brew at $BREW_LOCATION? (y/n)\n"
  read Brew
  if [ "$Brew" == "y" ];
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "Exiting Process."
    exit 1
  fi
fi

if [ "$SHELL" != "$BASH_LOCATION" ];
then
  echo "Bash (located at $BASH_LOCATION) must be your default shell to continue"
  echo "Set bash as your default shell? (y/n)"
  read DefaultBash
  if [ "$DefaultBash" == "y" ];
  then
    if ! [ -f "$BASH_LOCATION" ];
    then
      echo "$BASH_LOCATION does not exist. Make sure bash is installed at $BASH_LOCATION"
      exit 1
    fi
    if ! grep -Fxq "$BASH_LOCATION" /etc/shells ;
      then
        echo "You must have $BASH_LOCATION as a default login shell in /etc/shells. Add it now to continue (sudo required)? (y/n)"
        read DefaultBashShell
        if [ "$DefaultBashShell" == "y" ];
          then
            echo "$BASH_LOCATION" | sudo tee -a /etc/shells
          else
            echo "Exiting Process."
            exit 1
        fi
    fi
    echo "Setting $BASH_LOCATION as your default shell. You will need to provide sudo privledges for this."
    chsh -s $BASH_LOCATION
    echo "Reloading your terminal to account for changes and continuing where you left off"
    $BASH_LOCATION
  else
    echo "Exiting Process."
    exit 1
  fi
fi


echo ""
echo "Setup Choices:"
echo "=============="

echo "Generate Git Credentials? (y/n)"
read Git

echo "Install Python 3 (with brew)? (y/n)"
read Py3

echo "Setup Python Virtualenvs (for python3)? (y/n)"
read PyVenv

echo "Setup Node (NVM, Node v14 via NVM, NPM via NVM, and Yarn via brew)? (y/n)"
read NodeJS

echo "Setup remote services (openVPN and SSH)? (y/n)"
read Remote

echo "=============="
echo "Are all above Selections Correct? (y/n)"
read Correct

echo "=============="
if [ "$Correct" == "y" ];
then
  touch ~/StartLog.txt
  echo "Custom Start Installation Starting" | tee -a ~/StartLog.txt

  ./scripts/basics.sh | tee -a ~/StartLog.txt
  echo "========="
  if [ "$Git" == "y" ];
  then
    ./scripts/GitCredential.sh | tee -a ~/StartLog.txt
    echo "========="
  fi
  if [ "$Py3" == "y" ];
  then
    ./scripts/py3.sh $BREW_LOCATION | tee -a ~/StartLog.txt
    echo "========="
  fi
  if [ "$PyVenv" == "y" ];
  then
    ./scripts/venv.sh | tee -a ~/StartLog.txt
    echo "========="
  fi
  if [ "$NodeJS" == "y" ];
  then
    ./scripts/nvm.sh | tee -a ~/StartLog.txt
    echo "========="
  fi
  if [ "$Remote" == "y" ];
  then
    ./scripts/remote.sh | tee -a ~/StartLog.txt
    echo "========="
  fi
  echo "MacQS process complete!"
  exit 1
else
  echo "Restarting Process."
  ./run.sh
  exit 1
fi
