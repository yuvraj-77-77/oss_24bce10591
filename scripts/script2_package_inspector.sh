#!/bin/bash
# script 2: check if a package is installed

pkg="vlc"

echo "Checking for $pkg..."

# check if dpkg (Debian/Ubuntu package manager) is available
if command -v dpkg &> /dev/null; then
    if dpkg -l "$pkg" &> /dev/null; then
        echo "Status: Installed"
        dpkg -s "$pkg" | egrep 'Version|Homepage|Description'
    else
        echo "Status: Not installed"
        echo "Run: sudo apt install $pkg"
    fi
# fallback to checking rpm (Red Hat/Fedora) if dpkg isn't around
elif command -v rpm &> /dev/null; then
    if rpm -q "$pkg" &> /dev/null; then
        echo "Status: Installed"
        rpm -qi "$pkg" | egrep 'Version|License|Summary'
    else
        echo "Status: Not installed"
        echo "Run: sudo dnf install $pkg"
    fi
else
    echo "error: dpkg or rpm not found."
    exit 1
fi

echo ""
case $pkg in
    vlc)
        echo "Note: VLC was born in a French university."
        echo "It has billions of downloads and respects user freedom under GPL/LGPL."
        ;;
    httpd|apache2)
        echo "Note: Apache built the open internet."
        ;;
    firefox)
        echo "Note: Firefox fights for an open web."
        ;;
    python|python3)
        echo "Note: Python is shaped by the community (PEPs)."
        ;;
    *)
        echo "Note: Open source is cool."
        ;;
esac
