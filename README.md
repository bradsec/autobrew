# AutoBrew

AutoBrew is bash shell script to automate and batch install a custom list of macOS terminal packages or GUI applications using the Homebrew (https://brew.sh) package manager. Ideal for new macOS installations or macOS VMs to save time installing individual packages or using the Apple App Store.

### Requirements

Homebrew does require Xcode command line tools. Use the command below from a terminal window to install.

`xcode-select --install`

### Usage 

***Run the following commands as a NORMAL user.***  
*(Homebrew does not need to be run as root or a superuser with sudo or su)*  

**Method 1 (Quick easy setup):** One liner install using curl or wget. Use one of the following command lines:-  

`bash -c "$(curl -fsSL https://raw.githubusercontent.com/bradsec/autobrew/main/autobrew.sh)"`
  
`bash -c "$(wget -O- https://raw.githubusercontent.com/bradsec/autobrew/main/autobrew.sh)"`
  
**Method 2 (Manual method):** Clone and run locally.

`git clone https://github.com/bradsec/autobrew.git && bash autobrew/autobrew.sh`

### Note(s):

Due to the security settings in macOS when you run some packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may also need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
