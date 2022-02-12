# MacQS
An interactive script to quickstart a new Mac for development purposes


# Features

Automatically install and configure the following for the Mac:

- Brew (Package Manager)
  - Upgrade with brew
- Bash (Most recent version as the default shell)
  - Upgrade with brew

Optionally install and/or setup the following programs:

- Git Credentials
  - To print see your id_rsa.pub `cat ~/.ssh/id_rsa.pub`
  - Upgraded by Apple
- Python3 + Pip3
  - To access: `python3` and `pip3` (upgrade with brew)
- Virtualenv (for python3 via pip3)
  - Standard create venv `python3 -m virtualenv venv`
  - Standard activate venv `source venv/bin/activate`
  - Quick create venv `makevenv` (it is activated after creation)
  - Quick activate venv `vact`
  - Upgrade virtualenv with pip3
- Node (NVM, NPM and Yarn)
  - To access NVM `nvm --help`
  - To access node `node` (upgrade with nvm)
  - To access npm `npm` (upgrade with nvm)
  - To access yarn `yarn` (upgrade with brew)
- Remote services (openVpn and SSH)
  - openVpn (access with `openvpn --config yourfile.config`)
    - Upgrade with brew
  - SSH (access with `ssh`)
    - Upgraded by Apple


# Usage

```sh
./run.sh
```
