# AutoBrew

AutoBrew is bash shell script to automate and batch install a custom list of macOS terminal packages or GUI applications using the Homebrew (https://brew.sh) package manager. The script will also install homebrew if it is not already installed. Ideal for new macOS installations or macOS VMs to save time installing individual packages or using the Apple App Store.

### Requirements

Homebrew does require the Xcode commandline tools. Use the command `xcode-select --install` from a terminal window to install. The script will prompt if the commandline tools are not installed. The homebrew installer does install the commandline tools however it does not give progress of the installation like installing them manually does. The commandline tools are quite large and may take time depending on your Internet connection speed.

### Usage 

#### To customise your own list of applications use the following method -

1. Download and extract the respository.

2. Edit `autobrew.sh` with a text editor and modify the `tap_list`, `term_list` and `cask_list` variables under the `main()` function with the applications or packages you want to install. Comment out any lists if they not required or leave blank. The `tap_list` may not be required unless you need applications or packages which are not in the core Homebrew tap. *In the example the tap `homebrew/cask-fonts` has been add to the `tap_list` variable as this then allows for installation of fonts such as the `font-fira-code` shown under the `cask_list`.*

3. Run the script with `bash autobrew.sh` or `chmod +x autobrew.sh` followed by `./autobrew.sh`. *The script can be run as a normal user not as root or with sudo, however you may be prompted for a password to install Xcode commandline tools and the main homebrew package if they are not already installed.*

#### To run the script direct you can use `curl` or `wget` (if already installed) with one of the following commands -  

`bash -c "$(curl -fsSL https://raw.githubusercontent.com/bradsec/autobrew/main/autobrew.sh)"`
  
`bash -c "$(wget -O- https://raw.githubusercontent.com/bradsec/autobrew/main/autobrew.sh)"`

### Note(s):

- After the initial Xcode commmand line tools install and homebrew install most applications will be unattended and not require user input. However, some applications which require greater system or kernel access such as virus scanners like `malwarebytes` etc. may require your password.  
- Due to the security settings in macOS when you run some brew installed packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may also need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
