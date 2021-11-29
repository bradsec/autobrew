# AutoBrew

### Description

AutoBrew is bash shell script to automate the installation of a custom list of macOS terminal and GUI packages/applications using the Homebrew (https://brew.sh) package manager. Ideal for new macOS installations to save time finding and installing individual packages.

### Requirements

Homebrew does require Xcode command line tools. Use the command below from a terminal window to install.

`xcode-select --install`

### Usage 

**Method 1 (Quick easy setup):** One liner install using curl or wget. Use one of the following command lines:-  

`sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/bradsec/autobrew/main/autobrew.sh)"`
  
`sudo bash -c "$(wget -O- https://raw.githubusercontent.com/bradsec/autobrew/main/autobrew.sh)"`
  
**Method 2 (Manual method):** Clone and run locally.

`git clone https://github.com/bradsec/autobrew.git && sudo bash autobrew/autobrew.sh`

### Note(s):

Due to the security settings in macOS when you run some packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may also need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
