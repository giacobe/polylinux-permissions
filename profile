#!/bin/sh
PS1='\W$ '
export PS1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH
cd "$HOME" || exit 1
clear
box_line() { printf '* %-36.36s *\n' "$1"; }
echo '****************************************'
box_line 'PolyLinux: Users and Permissions'
box_line 'Read README.txt to begin.'
box_line 'Run validate when finished.'
box_line 'Use nextlevel and prevlevel.'
echo '****************************************'
cat README.txt
