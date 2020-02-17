## mac-brewski.sh
[ Tested February 2020 MacOS Catalina ]

**Description / Purpose**

Shell script to automate the installation of a custom list of MacOS terminal and GUI packages/applications using Homebrew (https://brew.sh) package manager. Great for new MacOS installations to save time finding and installing individual packages.

**Usage**

Clone, edit to the script customise packages etc. and run manually.

`bash mac-brewski.sh`

Alternatively use the curl command shown below (this will install the default packages/applications listed in script):

`bash -c "$(curl -fsSL https://raw.githubusercontent.com/mtbradley/brewski/master/mac-brewski.sh)"`

**Notes**

Due to the security in MacOS when you run the packages/applications for the first time you may need to allow them in the 'Security & Privacy' settings. Depending on the application you may need to grant access to the required area under 'Security & Privacy' > 'Privacy' tab.
