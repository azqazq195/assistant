#!/bin/bash

RED='\e[0;31m'
GREEN="\e[1;32m"
NC='\e[0m'

# github api 용 변수 준비
GIT_TOKEN="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"
GIT_CREATE_RELEASE="https://api.github.com/repos/azqazq195/assistant/releases"
FILE="D:\DEV\Code\Project\assistant\flutter\fluent.msix"
RELEASENOTE="D:/DEV/Code/Project/assistant/flutter/release_note"

VERSION="1.0.6.2"

# release md 작성
cd $RELEASENOTE
# BODY=$(< ${VERSION}.md)
# BODY=$(sed ':a;N;$!ba;s/\n/  /g' ${VERSION}.md)
# markdown=$(sed 's/$/\\n/' ${VERSION}.md | tr -d '\n')
BODY=$(sed ':a;N;$!ba;s/\n/\\n/g' ${VERSION}.md)
echo -e " >  $BODY"

# Release 생성
echo -e " > ${GREEN}create release..${NC}"
RESPONSE=$(curl \
 -X POST \
 -H "Content-Type:application/json" \
 -H "Authorization: token $GIT_TOKEN" \
 $GIT_CREATE_RELEASE \
 -d "
 {
   \"tag_name\": \"v$VERSION\",
   \"name\": \"v$VERSION\",
   \"body\": \"SSIBAL\",
   \"draft\": false,
   \"prerelease\": false
 }")

echo -e "$RESPONSE"

read -p "Press enter to continue"

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