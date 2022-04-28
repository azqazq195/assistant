# !/bin/bash

GREEN="\033[1;32""m"
NC="\033[0m"

echo "${GREEN} > docker login ${NC}"
docker login
echo "${GREEN} > stop container ${NC}"
docker stop assistant_server
echo "${GREEN} > remove container ${NC}"
docker rm assistant_server
echo "${GREEN} > pull latest image ${NC}"
docker pull azqazq195/assistant_server
echo "${GREEN} > run container ${NC}"
docker run -d -p 9090:9090 --name=assistant_server --restart=always -v /var/log/assistant_server:/workspace/logs -v /var/run/docker.sock:/var/run/docker.sock -v assistant_server_data:/data azqazq195/assistant_server
