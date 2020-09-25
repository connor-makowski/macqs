#!/bin/bash

BASH_PROFILE=~/.bash_profile
if [ -f "$BASH_PROFILE" ];
then
  echo "$BASH_PROFILE exists."
else
  echo "$BASH_PROFILE does not exist."
  echo "Generating $BASH_PROFILE"
  cp ./.bash_profile $BASH_PROFILE
  echo "Sourcing $BASH_PROFILE"
  source $BASH_PROFILE
fi

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Set up git default to not track filemodes"
git config --global core.filemode false

echo "Make sure ~/.bash_aliases exists"
touch ~/.bash_aliases
