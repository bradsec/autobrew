# AutoBrew

AutoBrew is bash shell script to automate and batch install a custom list of macOS terminal packages or GUI applications using the Homebrew (https://brew.sh) package manager. Ideal for new macOS installations or macOS VMs to save time installing individual packages or using the Apple App Store.

### Requirements

Homebrew does require Xcode command line tools. Use the command below from a terminal window to install.

`xcode-select --install`

### Usage 

1. Clone the respository `git clone https://github.com/bradsec/autobrew.git`

2. Edit `autobrew.sh` and modify the `tap_list`, `term_list` and `cask_list` variables under the `main()` function with the applications you want to install. Comment out any lists if they not required or leave blank.

```
    tap_list="homebrew/cask-fonts"
    term_list="htop wget curl"
    cask_list="the-unarchiver vlc font-fira-code"
```
3. Run the script with `bash autobrew.sh` or `chmod +x autobrew.sh` followed by `./autobrew.sh`.

### Note(s):

Due to the security settings in macOS when you run some packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may also need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
