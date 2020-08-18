## mac-brewski.sh

**Description / Purpose**

Bash shell script to automate the installation of a custom list of MacOS terminal and GUI packages/applications using Homebrew (https://brew.sh) package manager. Ideal for new MacOS installations to save time finding and installing individual packages.

**Requirements**

Homebrew does require Xcode command line tools. Use the command below from a terminal window to install.

`xcode-select --install`

## Usage

**Method 1: Quick one-liner install**

Use the curl command shown below (this will install the default packages/applications listed in script):

`bash -c "$(curl -fsSL https://raw.githubusercontent.com/mtbradley/brewski/master/mac-brewski.sh)"`

**Method 2: Manually clone and edit**

Clone, edit the script to customise packages etc. and run manually.

The packages/applications installed by the script are located under located under the 'brew_packages()' function.

```
brew_packages() {
    # addition taps to enable packages not included in core tap
    tap_list="homebrew/cask-fonts"
    # term_list includes packages which run from terminal without GUI
    term_list="openssh mas git vim htop wget curl nmap speedtest-cli tree tmux rsync
    iperf3 jq docker"
    # cask_list includes packages macOS apps, fonts and plugins and other non-open source software
    cask_list="iterm2 the-unarchiver visual-studio-code sublime-text google-chrome
    firefox alfred fontbase rectangle font-fira-code vlc"
    term_message cb "\nAdding additional Homebrew taps..."
```

Run using: `bash mac-brewski.sh`

## Notes

Due to the security settings in MacOS when you run the packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may also need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
