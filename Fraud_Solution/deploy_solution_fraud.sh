#!/bin/bash

# check some stuff before starting
if [[ ! $(which docker) && ! $(docker --version) ]]; then
  echo "This workshop depends on Docker and docker-compose. Please install them on your system."
  echo "Howto install Docker: https://docs.docker.com/engine/install"
  echo ".... and for compose: https://docs.docker.com/compose/install"
  exit 2
fi

if [[ ! $(which docker-compose) && ! $(docker-compose --version) ]]; then
    echo "This workshop depends on Docker and docker-compose. Please install them on your system."
    echo "Howto install Docker: https://docs.docker.com/engine/install"
    echo ".... and for compose: https://docs.docker.com/compose/install"
    exit 2
fi

echo " "
echo "####"
echo "Pulling latest version of tgdash image"

docker pull zrouga/tgdash:latest

echo " "
echo "####"
echo "Starting container and downloading all images"
docker-compose run --rm server create_db
docker-compose up -d

echo "####"
echo "Current containers running"
echo " "

docker-compose ps

echo " "
echo "####"
echo "To stop this project:        docker-compose stop"
echo "To terminate this project:   docker-compose down"
echo "####"

# read -s -p "Enter TigerGraph Password: " password
echo ''
echo "####"
echo "Checking TigerGraph connection"
if ssh -t -p 14022 tigergraph@localhost "test -f data/client.csv"
then
    echo ''
    echo "####"
    echo "Connecting to TigerGraph "
    ssh -t -p 14022 tigergraph@localhost
else
    echo " "
    echo "####"
    echo "Copying fraud data and install script"
    scp -P 14022 runDPInstall.sh fraudData.tar.gz tigergraph@localhost:~/

    echo ''
    echo "####"
    echo "Connecting to TigerGraph "
    ssh -t -p 14022 tigergraph@localhost "tar -xzvf fraudData.tar.gz; /bin/bash -i"
fi
