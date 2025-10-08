#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Create opt directory
mkdir /var/opt/

# Remove packages not needed
dnf5 remove -y waydroid webapp-manager sunshine

# Install Zen
dnf5 copr enable -y sneexy/zen-browser 
dnf5 install -y zen-browser
dnf5 copr disable -y sneexy/zen-browser

# Install 1Password
rpm --import https://downloads.1password.com/linux/keys/1password.asc
sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
dnf5 install -y 1password
