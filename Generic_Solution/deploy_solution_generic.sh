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

FILE=tgSolutionPackData.tar.gz
if [ ! -f "$FILE" ]; then
    echo " "
    echo "####"
    echo "Downloading tgSolutionPack data"
    wget https://tgsedemodatabucket.s3.amazonaws.com/tgSolutionPackData.tar.gz
fi


# read -s -p "Enter TigerGraph Password: " password
echo ''
echo "####"
echo "Checking TigerGraph connection"
if ssh -t -p 14022 tigergraph@localhost "test -d mydata"
then
    echo ''
    echo "####"
    echo "Connecting to TigerGraph "
    ssh -t -p 14022 tigergraph@localhost "cd mydata; /bin/bash -i"
else
    echo " "
    echo "####"
    echo "Copying tgSolutionPack files"
    scp -P 14022 tgSolutionPack.tar.gz tgSolutionPackData.tar.gz tigergraph@localhost:~/

    echo ''
    echo "####"
    echo "Connecting to TigerGraph "
    ssh -t -p 14022 tigergraph@localhost "mkdir ~/mydata; cd mydata; tar -xzvf ../tgSolutionPack.tar.gz; tar -xzvf ../tgSolutionPackData.tar.gz; cd tgSolutionPack; /bin/bash -i"
fi
