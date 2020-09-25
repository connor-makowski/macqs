#!/bin/bash
echo "Installing virtualenv"
pip install virtualenv
echo "Adding Quick Access to make and activate virtualenvs as makevenv and venv"
echo '# Quick Access to build and activate virtualenvs' >> ~/.bash_aliases
echo 'alias makevenv="python3 -m virtualenv venv && vact"' >> ~/.bash_aliases
echo 'alias vact="source venv/bin/activate"' >> ~/.bash_aliases
echo "Done adding quick access for virtualenvs"
