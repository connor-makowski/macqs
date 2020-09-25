#!/bin/bash
echo "Installing openvpn"
brew install openvpn

echo "Setup alias for connecting to openvpn"
echo '# Make openvpn connection alias' >> ~/.bash_aliases
echo "alias ovpn='openvpn --config ~/config.ovpn'" >> ~/.bash_aliases
echo "Done setting up open vpn alias"

echo "Enabling Remote Login"
sudo systemsetup -setremotelogin on
