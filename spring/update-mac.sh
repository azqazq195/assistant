# !/bin/bash

RED="\033[1;31""m"
GREEN="\033[1;32""m"
YELLOW="\033[1;33""m"
BLUE="\033[1;34""m"
PINK="\033[1;35""m"
NC="\033[0m"

YAML="/Users/moonseongha/Documents/Code/Project/assistant/spring/src/main/resources/application.yml"

echo "${GREEN} > change yml profile 'local -> dev'${NC}"
yq -i '.spring.config.import[0] = "classpath:application-dev.yml"' $YAML

echo "${GREEN} > commit comment: ${NC}"
read COMMIT

git pull origin master
git add .
git commit -m "$COMMIT"

echo "${GREEN} > git push.. ${NC}"
git push origin master

echo "${GREEN} > build jar.. ${NC}"
./gradlew clean build -x test 

echo "${GREEN} > build docker image.. ${NC}"
docker build -t azqazq195/assistant_server .

echo "${GREEN} > docker login.. ${NC}"
docker login

echo "${GREEN} > docker push.. ${NC}"
docker push azqazq195/assistant_server

echo "${GREEN} > change yml profile 'dev -> local'${NC}"
yq -i '.spring.config.import[0] = "classpath:application-local.yml"' $YAML

echo "${GREEN} >>> DONE <<<'${NC}"