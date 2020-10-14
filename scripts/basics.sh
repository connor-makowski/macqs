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

if [ -f ~/.bash_aliases ];
then
    echo "~/.bash_aliases exists"
  else
    echo "~/.bash_aliases does not exist. Creating one."
    touch ~/.bash_aliases
fi

echo "Set git default to not track filemodes"
git config --global core.filemode false
