#!/bin/bash
echo "Only use on macOS"

echo "In System Preferences > Users & Groups"
echo "Cmd + Click on your name and go to Advanced Options"
echo "Make sure your login shell is /bin/bash"
echo "=============="
echo "Is your login shell /bin/bash? (y/n)"
read BashSetup
if ["$BashSetup" == "n"];
then
  echo ""
  echo "Setup Choices:"
  echo "=============="
else
  echo "Make sure your login shell is /bin/bash."
  echo "Exiting Process."
  exit 1
fi

echo "Brew Must be installed to continue: Install Brew? (y/n)"
read Brew
if [ "$Brew" == "y" ];
then
  :
else
  echo "Exiting Process."
  exit 1
fi

echo "Generate Git Credentials? (y/n)"
read Git

echo "Install Python 3? (y/n)"
read Py3

echo "Setup Python Virtualenvs? (y/n)"
read PyVenv

echo "Setup NVM and Node v12? (y/n)"
read NodeJS

echo "Setup remote services (openVPN and SSH)? (y/n)"
read Remote

echo "Setup PostgreSQL? (y/n)"
read PostgreSQL

echo "Setup MySQL? (y/n)"
read MySQL

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
