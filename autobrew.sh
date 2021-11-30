#!/usr/bin/env bash

set -o errexit
set -o pipefail

# Function to output details of script.
script_info() {
    cat <<EOF
                                                    
Name:           autobrew.sh
Description:    Automate the installation of macOS 
                applications and packages using homebrew
Author:         Mark Bradley
Requirements:   Command Line Tools (CLT) for Xcode

EOF
}

# Function to set terminal colors if supported.
term_colors() {
    if [[ -t 1 ]]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        MAGENTA=$(printf '\033[35m')
        CYAN=$(printf '\033[36m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[0m')
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        MAGENTA=""
        CYAN=""
        BOLD=""
        RESET=""
    fi
}

# Function to output colored or bold terminal messages.
# Usage examples: term_message "This is a default color and style message"
#                 term_message nb "This is a default color bold message"
#                 term_message rb "This is a red bold message"
term_message() {
    local set_color=""
    local set_style=""
    [[ -z "${2}" ]] && echo -ne "${1}" >&2 && return
    [[ ${1:0:1} == "d" ]] && set_color=${RESET}
    [[ ${1:0:1} == "r" ]] && set_color=${RED}
    [[ ${1:0:1} == "g" ]] && set_color=${GREEN}
    [[ ${1:0:1} == "y" ]] && set_color=${YELLOW}
    [[ ${1:0:1} == "b" ]] && set_color=${BLUE}
    [[ ${1:0:1} == "m" ]] && set_color=${MAGENTA}
    [[ ${1:0:1} == "c" ]] && set_color=${CYAN}
    [[ ${1:1:2} == "b" ]] && set_style=${BOLD}
    echo -e "${set_color}${set_style}${2}${RESET}" >&2 && return
}

# Displays a box containing a dash and message
task_start() {
    echo -ne "[-] ${1}"
}

# Displays a box containing a green tick and optional message if required.
task_done() {
    echo -e "\r[\033[0;32m\xE2\x9C\x94\033[0m] ${1}"
}

# Displays a box containing a red cross and optional message if required.
task_fail() {
    echo -e "\r[\033[0;31m\xe2\x9c\x98\033[0m] ${1}"
}

# Function to pause script and check if the user wishes to continue.
check_continue() {
    local response
    while true; do
        read -r -p "Do you wish to continue (y/N)? " response
        case "${response}" in
        [yY][eE][sS] | [yY])
            echo
            break
            ;;
        *)
            echo
            exit
            ;;
        esac
    done
}

# Function check command exists
command_exists() {
    command -v "${@}" >/dev/null 2>&1
}

check_xcode() {
    term_message cb "Checking for setup dependencies..."
    task_start "Checking for Xcode command line tools..."
    if xcode-select -p >/dev/null 2>&1; then
        task_done "Xcode command line tools are installed.$(tput el)"
    else
        task_fail "\n"
        term_message mb "Attempting to install Xcode command line tools..."
        if xcode-select --install >/dev/null 2>&1; then
            term_message gb "Re-run script after Xcode command line tools have finished installing.\n"
        else
            term_message rb "Xcode command line tools install failed.\n"
        fi
        exit 1
    fi
}

install_homebrew() {
    term_message cb "\nInstalling Homebrew..."
    task_start "Checking for Homebrew..."
    if command_exists "brew"; then
        task_done "Homebrew is installed.$(tput el)"
        task_start "Running brew update..."
        if brew update >/dev/null 2>&1; then
            task_done "Brew update completed.$(tput el)"
        else
            task_fail "Brew update failed.$(tput el)"
        fi
        task_start "Running brew upgrade..."
        if brew upgrade >/dev/null 2>&1; then
            task_done "Brew upgrade completed.$(tput el)"
        else
            task_fail "Brew upgrade failed.$(tput el)"
        fi
    else
        task_fail "\n"
        term_message mb "Attempting to install Homebrew..."
        if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
            task_done "Homebrew installed.\n"
        else
            task_fail "Homebrew install failed.\n"
            exit 1
        fi
    fi
}

brew_packages() {
    if [[ ! -z "$tap_list" ]]; then
        term_message cb "\nAdding additional Homebrew taps..."
        for tap in ${tap_list}; do
            task_start "Checking for tap > ${tap}"
            if brew tap | grep "${tap}" >/dev/null 2>&1 || command_exists "${tap}"; then
                task_done "Tap ${tap} already added.$(tput el)"
            else
                task_fail "\n"
                term_message mb "Attempting to add tap ${tap}..."
                if brew tap "${tap}"; then
                    task_done "Tap ${tap} added.\n"
                else
                    task_fail "Unable to add tap ${tap}.\n"
                fi
            fi
        done
    fi
    if [[ ! -z "$term_list" ]]; then
        term_message cb "\nInstalling brew terminal packages..."
        for pkg in ${term_list}; do
            task_start "Checking for package > ${pkg}"
            if brew list "${pkg}" >/dev/null 2>&1 || command_exists "${pkg}"; then
                task_done "Package ${pkg} already installed.$(tput el)"
            else
                task_fail "\n"
                term_message mb "Attempting to install ${pkg}..."
                if brew install "${pkg}"; then
                    task_done "Package ${pkg} installed.\n"
                else
                    task_fail "Package ${pkg} install failed.\n"
                fi
            fi
        done
    fi
    if [[ ! -z "$cask_list" ]]; then
        term_message cb "\nInstalling brew cask packages..."
        for cask in ${cask_list}; do
            task_start "Checking for cask package > ${cask}"
            if brew list --cask "${cask}" >/dev/null 2>&1; then
                task_done "Package ${cask} already installed.$(tput el)"
            else
                task_fail "\n"
                term_message mb "Attempting to install ${cask}..."
                if brew install --cask "${cask}"; then
                    task_done "Package ${cask} installed.\n"
                else
                    task_fail "Package ${cask} install failed.\n"
                fi
            fi
        done
    fi
}

brew_cleanup() {
    task_start "Running brew cleanup..."
    if brew cleanup >/dev/null 2>&1; then
        task_done "Brew cleanup completed.$(tput el)"
    else
        task_fail "Brew cleanup failed.$(tput el)"
    fi
}

# One function to rule them all.
main() {
    # Customise the following list variables (tap_list, term_list and cask_list) 
    # Leave list blank or comment out the list if not required.
    tap_list="homebrew/cask-fonts"
    term_list="git htop wget curl tmux"
    cask_list="the-unarchiver vlc visual-studio-code google-chrome \
    firefox adobe-acrobat-reader malwarebytes font-fira-code"
    clear
    term_colors
    script_info
    check_continue
    check_xcode
    install_homebrew
    brew_packages
    brew_cleanup
    term_message gb "\nScript completed."
}

main "${@}"
