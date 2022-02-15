#!/bin/bash

BASH_PROFILE=~/.bash_profile
if [ -f "$BASH_PROFILE" ];
then
  echo "$BASH_PROFILE exists."
  echo "You should consider copying the contents of macqs/.bash_profile to your local ~/.bash_profile"
else
  echo "$BASH_PROFILE does not exist."
  echo "Generating $BASH_PROFILE"
  cp ./.bash_profile $BASH_PROFILE
  echo "Sourcing $BASH_PROFILE"
  source $BASH_PROFILE
fi
echo "========="
if [ -f ~/.bash_aliases ];
then
    echo "~/.bash_aliases exists. No need to create a new one."
  else
    echo "~/.bash_aliases does not exist. Creating one."
    touch ~/.bash_aliases
fi
echo "========="
echo "Set git default to not track filemodes"
git config --global core.filemode false
