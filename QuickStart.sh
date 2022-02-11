#!/bin/bash
echo "Only use on macOS"

cd "`dirname $0`"

BREW_BIN="/opt/homebrew/bin"
BASH_LOCATION="$BREW_BIN/bash"
BREW_LOCATION="$BREW_BIN/brew"

PATH=$BREW_BIN:$PATH

if [ "$(which brew)" != "$BREW_LOCATION" ];
then
  echo "Brew Must be installed to continue: Install Brew? (y/n)"
  read Brew
  if [ "$Brew" == "y" ];
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "Exiting Process."
    exit 1
  fi
fi

if [ "$(which bash)" != "$BASH_LOCATION" ];
then
  echo "Bash must be installed (via brew) to continue: Install bash? (y/n)"
  read Bash
  if [ "$Bash" == "y" ];
  then
    brew install bash
  else
    echo "Exiting Process."
    exit 1
  fi
fi

if [ "$SHELL" != "$BASH_LOCATION" ];
then
  echo "Bash (from brew located at $BASH_LOCATION) must be your default shell to continue: Set bash as your default shell? (y/n)"
  read DefaultBash
  if [ "$DefaultBash" == "y" ];
  then
    if ! [ -f "$BASH_LOCATION" ];
    then
      echo "$BASH_LOCATION does not exist. Make sure bash is installed with brew at $BASH_LOCATION"
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
    echo "Please use the new terminal window to finish this process. You can now exit from this terminal."
    open -a Terminal.app ./QuickStart.sh && exit 1
    exit 1
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

echo "Install Python 3? (y/n)"
read Py3

echo "Setup Python Virtualenvs? (y/n)"
read PyVenv

echo "Setup Node (NVM, Node v14(via NVM), NPM (via NVM) and Yarn(via brew))? (y/n)"
read NodeJS

echo "Setup remote services (openVPN and SSH)? (y/n)"
read Remote

echo "=============="
echo "Are all above Selections Correct? (y/n)"
read Correct

if [ "$Correct" == "y" ];
then
  touch ~/StartLog.txt
  echo "Custom Start Installation Starting" | tee -a ~/StartLog.txt

  ./scripts/basics.sh | tee -a ~/StartLog.txt

  if [ "$Git" == "y" ];
  then
    ./scripts/GitCredential.sh | tee -a ~/StartLog.txt
  fi
  if [ "$Py3" == "y" ];
  then
    ./scripts/py3.sh | tee -a ~/StartLog.txt
  fi
  if [ "$PyVenv" == "y" ];
  then
    ./scripts/venv.sh | tee -a ~/StartLog.txt
  fi
  if [ "$NodeJS" == "y" ];
  then
    ./scripts/nvm.sh | tee -a ~/StartLog.txt
  fi
  if [ "$Remote" == "y" ];
  then
    ./scripts/remote.sh | tee -a ~/StartLog.txt
  fi
  exit 1
else
  echo "Restarting Process."
  ./QuickStart.sh
  exit 1
fi
