# MacQS
An interactive script to quickstart a new Mac for development purposes


# Features

Automatically install and configure the following for Mac machines:

- [Brew](https://brew.sh/) (Package Manager)
  - Upgrade with brew

Optionally install and/or setup the following programs:

- Git Credentials
  - To print see your id_rsa.pub `cat ~/.ssh/id_rsa.pub`
  - Upgraded by Apple
- Python3 + Pip3
  - NOTE: Newer macOSs have python3 installed by default
  - To access: `python3` and `pip3`
    - python3: upgrade with Brew if you install with this script
    - pip3: upgrade with `python3 -m pip3 install --upgrade pip3`
      - Note: depending on the setup, sometimes `pip3` can be `pip`
- Virtualenv (for python3 via pip3)
  - Standard create venv `python3 -m virtualenv venv`
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
  - openVpn (access with `openvpn --config yourfile.config`)
    - Upgrade with brew
  - SSH (access with `ssh`)
    - Upgraded by Apple


# Apple Silicon (M1)

On Apple silicon (M1) machines, not all programs and packages work natively yet.

To solve this problem, you can use Rosetta 2 (an Apple provided translation software):

- Rosetta 2 can  convert Intel (`x86_64`) instruction sets to Apple silicon (`arm64`)
- This means you can run Intel instructions and programs on Apple Silicon
- This is very helpful for coding projects that use packages not yet functional on `arm64`


## Convert Your Terminal To Run Intel Instructions By Default Using Rosetta2
Lets create a terminal running with Rosetta2 for Intel (`x86_64`):

1. Open your terminal app
  - Found in `Applications/Utilities`
  - OR Launch with spotlight
    1. Press `cmd + space`
    2. Type `terminal`
    3. Press `enter`
2. Install Rosetta2 (from Apple) with:
  ```
  softwareupdate --install-rosetta
  ```
3. Close your Terminal app
4. Copy your Terminal App
  - In finder, navigate to `Applications/Utilities`
  - Click on `Terminal` and press `cmd+c` to copy it
  - Press `cmd+v` to paste Terminal into your utilities (as a copy)
  - Alternate click on one of your Terminal apps and rename it to `TerminalArm64`
    - Note: Should you ever need to use `arm64` instructions, you can launch this app
  - Now alternate click on `Terminal` and click `get info`
  - Expand the `general` section and check the box `Open using Rosetta`
  - Close the `Terminal Info`
5. Open Terminal and validate that it is using Intel instruction (`x86_64`)
  - Open Terminal
  - Type `uname -m` and press `enter`
  - You should see `x86_64` as output
    - If you see `arm64` as output, something was not configured correctly above
    - Double check that you completed the steps and try again


# Usage

1. Open your terminal app
  - Found in `Applications/Utilities`
  - OR Launch with spotlight
    1. Press `cmd + space`
    2. Type `terminal`
    3. Press `enter`

2. Clone this repository to your current directory with git:
  ```
  git clone https://github.com/connor-makowski/macqs.git
  ```
  - Note: You may be prompted to install developer tools to use `git`

3. Change directories into the macqs folder:
  ```
  cd macqs
  ```

4. Make sure you are currently using the correct architecture:
  - `macqs` only supports `x86_64` and `arm64`
    - You can validate your architecture by typing `uname -m` and pressing `enter` in `Terminal`
  - See the Apple Silicon Section above for more details if you have Apple Silicon (`arm64`)

5. Run the quick start program:
  - Note: This forces your default shell to bash and sets up `brew` as your package manager
  ```
  ./run.sh
  ```
