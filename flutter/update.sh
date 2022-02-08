#!/bin/bash

RED='\e[0;31m'
GREEN="\e[1;32m"
NC='\e[0m'

#echo -e " > ${GREEN}current version${NC}"
#cat pubspec.yaml | grep msix_version
#
#echo -e " > ${GREEN}enter versions: ${NC}"
#read version
#
##grep -n 'msix_version' pubspec.yaml | cut -d ':' -f1
#sed -i "45s/.*/  msix_version: $version/" pubspec.yaml
##echo -e " > ${GREEN}msix_version: $version${NC}"
#
#echo -e " > ${GREEN}build windows app..${NC}"
#cd D:/DEV/Code/Project/assistant/flutter
#flutter build windows
#
#echo -e " > ${GREEN}build installer..${NC}"
#flutter pub run msix:create

echo -e " > ${GREEN}git push..${NC}"
echo -e " > ${GREEN}commit comment: ${NC}"
read comment
git pull origin master
cd D:/DEV/Code/Project/assistant
git add .
git commit -m "$comment"
git push origin master

echo -e " > ${RED}done${NC}"

read -p "Press enter to continue"