#!/bin/bash
# init

RED='\e[0;31m'
GREEN="\e[1;32m"
NC='\e[0m'

PROJECT="D:/DEV/Code/Project/assistant"
FLUTTER="D:/DEV/Code/Project/assistant/flutter"
RELEASENOTE="D:/DEV/Code/Project/assistant/flutter/release_note"

# 버전 확인
echo -e " > ${GREEN}current version${NC}"
cd D:/DEV/Code/Project/assistant/flutter
cat pubspec.yaml | grep msix_version

# 새로운 버전 입력 및 코멘트 작성
echo -e " > ${GREEN}enter versions: ${NC}"
cd $FLUTTER
read VERSION
echo -e " > ${GREEN}git commit comment: ${NC}"
read COMMENT
LINE=$(grep -n 'msix_version' pubspec.yaml| cut -d ':' -f1)
sed -i "${LINE}s/.*/  msix_version: $VERSION/" pubspec.yaml

# release md 작성
echo -e " > ${GREEN}press [Enter] key after write release.md...${NC}"
cd $RELEASENOTE
> ${VERSION}.md
code .
read

BODY=$(sed ':a;N;$!ba;s/\n/\\n/g' ${VERSION}.md)

# Windows app 빌드
echo -e " > ${GREEN}build windows app..${NC}"
cd $FLUTTER
flutter build windows

# msix 생성
echo -e " > ${GREEN}build installer..${NC}"
cd $FLUTTER
flutter pub run msix:create

# github 커밋 및 푸쉬
echo -e " > ${GREEN}git push..${NC}"
git pull origin master
cd $PROJECT
git add .
git commit -m "$COMMENT"
git push origin master

# github api 용 변수 준비
GIT_TOKEN="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"
GIT_CREATE_RELEASE="https://api.github.com/repos/azqazq195/assistant/releases"
FILE="D:\DEV\Code\Project\assistant\flutter\assistant.msix"

# Release 생성
echo -e " > ${GREEN}create release..${NC}"
RESPONSE=$(curl \
 POST \
 -H "Content-Type:application/json" \
 -H "Authorization: token $GIT_TOKEN" \
 $GIT_CREATE_RELEASE \
 -d "
 {
   \"tag_name\": \"v$VERSION\",
   \"name\": \"v$VERSION\",
   \"body\": \"holly molly\",
   \"draft\": false,
   \"prerelease\": false
 }")

echo -e "$RESPONSE"

# Assets 업로드
echo -e " > ${GREEN}uplaod assets..${NC}"
RELEASED_ID=$(echo $RESPONSE | jq '.id')
GIT_UPLOAD_RELEASE="https://uploads.github.com/repos/azqazq195/assistant/releases/$RELEASED_ID/assets?name=$(basename $FILE)"
curl \
  -X PATCH \
  -H "Authorization: token $GIT_TOKEN" \
  -H "Content-Type: $(file -b --mime-type $FILE)" \
  --data-binary @$FILE \
  $GIT_UPLOAD_RELEASE

echo -e " > ${GREEN}done${NC}"

read -p "Press enter to continue"