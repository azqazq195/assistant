# !/bin/bash

RED="\033[1;31""m"
GREEN="\033[1;32""m"
YELLOW="\033[1;33""m"
BLUE="\033[1;34""m"
PINK="\033[1;35""m"
NC="\033[0m"

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

# ./gradlew bootBuildImage -Dspring.profiles.active=dev --imageName=azqazq195/assistant:"$TAG"

# echo "${GREEN} > docker push.. ${NC}"

# docker push azqazq195/assistant:"$TAG"

echo "${GREEN} > build docker image.. ${NC}"

./gradlew bootBuildImage -Dspring.profiles.active=dev --imageName=azqazq195/assistant_server

echo "${GREEN} > docker push.. ${NC}"

docker push azqazq195/assistant_server