# AutoBrew

AutoBrew is bash shell script to automate and batch install a custom list of macOS terminal packages or GUI applications using the Homebrew (https://brew.sh) package manager. Ideal for new macOS installations or macOS VMs to save time installing individual packages or using the Apple App Store.

### Requirements

Homebrew does require Xcode command line tools. Use the command below from a terminal window to install.

`xcode-select --install`

### Usage 

#### To customise your own list of applications use the following method -

1. Download and extract the respository

2. Edit `autobrew.sh` and modify the `tap_list`, `term_list` and `cask_list` variables under the `main()` function with the applications you want to install. Comment out any lists if they not required or leave blank. The `tap_list` may not be required unless you need applications or packages which are not in the core Homebrew tap.

3. Run the script with `bash autobrew.sh` or `chmod +x autobrew.sh` followed by `./autobrew.sh`. *The script can be run as a normal user not as root or with sudo, however you may be prompted for a password to install Xcode command line tools if they are not already installed.*

### Note(s):

Due to the security settings in macOS when you run some packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may also need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
