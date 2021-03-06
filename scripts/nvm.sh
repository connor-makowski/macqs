#!/bin/bash
echo "Installing NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
echo "NVM Install Complete"
echo "Installing most recent version of Node 12 and NPM"
nvm install v12
echo "Node and NPM Install Complete"
echo "Installing Yarn"
brew install yarn
echo "Yarn install complete"
