#!/bin/sh
PS1='\W$ '
cd "$HOME" || exit 1
clear
box_line() { printf '* %-36.36s *\n' "$1"; }
echo '****************************************'
box_line 'PolyLinux: Users and Permissions'
box_line 'Read README.txt to begin.'
box_line 'Submit the key from validate.'
box_line 'Use nextlevel and prevlevel.'
echo '****************************************'
cat README.txt
