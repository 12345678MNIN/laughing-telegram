#!/bin/bash

# This
echo "================================================="
echo "        Termux Nano Error Fixer v1.0"
echo "   A powerful script to fix common errors!"
echo "================================================="
figlet Htcs
function display_error {
    echo -e "\033[31m[ERROR] $1\033[0m"
}

function display_success {
    echo -e "\033[32m[SUCCESS] $1\033[0m"
}

function check_file_exists {
    if [ ! -f "$1" ]; then
        display_error "File '$1' not found!"
        exit 1
    fi
}

function check_nano_installed {
    if ! command -v nano &> /dev/null; then
        display_error "Nano is not installed! Please install it using 'pkg install nano'."
        exit 2
    fi
}

function check_script_syntax {
    bash -n "$1" &> /dev/null
    if [ $? -ne 0 ]; then
        display_error "Syntax error detected in the script '$1'."
        exit 3
    fi
}

function welcome_message {
    echo "Hello, welcome to the Termux Nano Error Fixer script!"
    echo "This tool helps you fix common issues with your nano editor."
    echo "Let's begin!"
}

function download_hydra {
    echo "Downloading THC Hydra..."
    pkg install -y git
    git clone https://github.com/vanhauser-thc/thc-hydra.git
    cd thc-hydra
    make
    display_success "THC Hydra has been downloaded and installed!"
}

echo "Please provide the file you want to edit (with full path):"
read FILE

welcome_message

if [ -z "$FILE" ]; then
    display_error "No file specified! Please provide a valid file to edit."
    exit 4
fi

check_nano_installed
check_file_exists "$FILE"
check_script_syntax "$FILE"

echo "Opening the file '$FILE' in nano..."
nano "$FILE"

if [ $? -ne 0 ]; then
    display_error "Error opening the file '$FILE' in nano."
    exit 5
fi

display_success "The file '$FILE' was successfully edited!"

echo "Please choose an option:"
echo "1) Missing file"
echo "2) Nano not installed"
echo "3) Syntax errors in script"
echo "4) File permissions issue"
echo "5) Other issues"
echo "6) Download THC Hydra"
echo "Enter the number corresponding to the action:"
read OPTION

case $OPTION in
    1)
        display_error "File does not exist. Please check the path and try again."
        ;;
    2)
        display_error "Install nano with 'pkg install nano'."
        ;;
    3)
        display_error "Check the syntax of your script for potential issues."
        ;;
    4)
        display_error "You may need to change the file permissions with 'chmod 755 <filename>'."
        ;;
    5)
        display_error "Other issues might involve system configurations or Termux environment settings."
        ;;
    6)
        download_hydra
        ;;
    *)
        display_error "Invalid option. Exiting."
        exit 6
        ;;
esac
