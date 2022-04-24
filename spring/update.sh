# !/bin/bash

RED="\033[1;31""m"
GREEN="\033[1;32""m"
YELLOW="\033[1;33""m"
BLUE="\033[1;34""m"
PINK="\033[1;35""m"
NC="\033[0m"

echo "${GREEN} > change yml profile 'local -> dev'${NC}"
yq -i '.spring.profiles.active = "dev"' src/main/resources/application.yml

echo "${GREEN} > commit comment: ${NC}"
read COMMIT

git pull origin master
git add .
git commit -m "$COMMIT"

echo "${GREEN} > git push.. ${NC}"

git push origin master

# echo "${GREEN} > build docker image.. ${NC}"
# echo "${GREEN} > docker image tag: ${NC}"
# read TAG

# ./gradlew bootBuildImage --args='--spring.profiles.active=dev' --imageName=azqazq195/assistant_server:"$TAG"

# echo "${GREEN} > docker push.. ${NC}"

# docker push azqazq195/assistant_server:"$TAG"

echo "${GREEN} > build docker image.. ${NC}"

./gradlew bootBuildImage --imageName=azqazq195/assistant_server

echo "${GREEN} > docker push.. ${NC}"

docker push azqazq195/assistant_server

echo "${GREEN} > change yml profile 'dev -> local'${NC}"
yq -i '.spring.profiles.active = "local"' src/main/resources/application.yml

echo "${GREEN} >>> DONE <<<'${NC}"