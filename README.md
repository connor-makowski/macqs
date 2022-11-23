# MacQS
An interactive script to quick start a new Mac for development purposes


# Usage

```
curl -o- https://raw.githubusercontent.com/connor-makowski/macqs/master/run.sh | bash
```


# Features

Automatically install and configure the following for Mac machines:

- [Brew](https://brew.sh/) (Package Manager)
  - Upgrade with brew

Optionally install and/or setup the following programs:

- Git Credentials (newly generated)
  - To print see your id_rsa.pub `cat ~/.ssh/id_rsa.pub`
  - Upgraded by Apple
- Python3.10 + Pip
  - NOTE: Newer macOSs have python3 installed by default
  - To access: `python3.10` and `pip`
    - python3: upgrade with Brew if you install with this script
      - `brew install python@3.10`
    - pip3: upgrade with `python3.10 -m pip install --upgrade pip`
- Virtualenv (for python3 via pip3)
  - Standard create venv `python3.10 -m virtualenv venv`
  - Standard activate venv `source venv/bin/activate`
  - Quick create venv `makevenv` (it is activated after creation)
  - Quick activate venv `vact`
  - Upgrade `virtualenv` with pip3
    - `pip3 install --upgrade virtualenv`
- Node (NVM, NPM and Yarn)
  - To access NVM `nvm --help`
  - To access node `node` (upgrade with [nvm](https://github.com/nvm-sh/nvm))
  - To access npm `npm` (upgrade with npm)
  - To access yarn `yarn` (upgrade with npm)
- Remote services (openVpn and SSH)
  - SSH (access with `ssh`)
    - Upgraded by Apple
    - Allows ssh access into your mac machine
