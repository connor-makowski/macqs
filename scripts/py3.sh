if [[ "$(which -a python3)" != "" ]]; then
  echo "Python3 is installed in the following locations:"
  printf "$(which -a python3)\n"
  echo "This will install Python3 with Brew for $HOSTNAME ($(uname -m)) at $1"
  echo "Are you sure? (y/n)"
  read ays_python
  if [[ "$ays_python" == "y" ]]; then
    echo "Installing python3"
    brew install python
    echo "Upgrading pip for python3"
    python3 -m pip install --upgrade pip || true
  else
    echo "Not installing python3"
  fi
else
  echo "Installing python3"
  brew install python
  echo "Upgrading pip for python3"
  python3 -m pip install --upgrade pip || true
fi
