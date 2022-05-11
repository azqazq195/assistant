# !/bin/bash

RED="\033[1;31""m"
GREEN="\033[1;32""m"
YELLOW="\033[1;33""m"
BLUE="\033[1;34""m"
PINK="\033[1;35""m"
NC="\033[0m"

YAML="/d/DEV/Code/Project/assistant/spring/src/main/resources/application.yml"

echo -e "${GREEN} > change yml profile 'local -> dev'${NC}"
yq -i '.spring.config.import[0] = "classpath:application-dev.yml"' $YAML

echo -e "${GREEN} > commit comment: ${NC}"
read COMMIT

git pull origin master
git add .
git commit -m "$COMMIT"

echo -e "${GREEN} > git push.. ${NC}"

git push origin master

# echo -e "${GREEN} > build docker image.. ${NC}"
# echo -e "${GREEN} > docker image tag: ${NC}"
# read TAG

# ./gradlew bootBuildImage --args='--spring.profiles.active=dev' --imageName=azqazq195/assistant_server:"$TAG"

# echo -e "${GREEN} > docker push.. ${NC}"

# docker push azqazq195/assistant_server:"$TAG"

echo -e "${GREEN} > build docker image.. ${NC}"

./gradlew clean bootBuildImage --imageName=azqazq195/assistant_server

echo -e "${GREEN} > docker login.. ${NC}"

docker login

echo -e "${GREEN} > docker push.. ${NC}"

docker push azqazq195/assistant_server

echo -e "${GREEN} > change yml profile 'dev -> local'${NC}"
yq -i '.spring.config.import[0] = "classpath:application-local.yml"' $YAML

echo -e "${GREEN} >>> DONE <<<'${NC}"