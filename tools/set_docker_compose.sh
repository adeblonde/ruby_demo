#!/bin/bash

### adapt sed for Kernel (MacOS doesn't have GNU sed)
sed_cmd="sed -i"
OS=$(uname)
echo "OS is " $OS
if [[ $OS != "Linux" ]]
then
    echo "not a Linux kernel"
    sed_cmd="sed -i ' '"
fi

export APP_NAME=$1

### let us replace the variables to set in docker-compose files
for env in development production
do
	cp $env/docker-compose.tpl.yml $env/docker-compose.yml
	$sed_cmd "s/APP_NAME/$APP_NAME/g" $env/docker-compose.yml
	$sed_cmd "s/mysql_db/${APP_NAME}_${env}/g" $env/docker-compose.yml
done