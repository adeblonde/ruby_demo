#!/bin/bash

export APP_NAME=$1

### backup of database.yml
mv $APP_NAME/config/database.yml $APP_NAME/config/database.bkp
### setting database.yaml
cp databases_config/database.yml $APP_NAME/config/database.yml

### adapt sed for Kernel (MacOS doesn't have GNU sed)
sed_cmd="sed -i"
OS=$(uname)
echo "OS is " $OS
if [[ $OS != "Linux" ]]
then
    echo "not a Linux kernel"
    sed_cmd="sed -i ' '"
fi

$sed_cmd "s/APP_NAME/$APP_NAME/g" $APP_NAME/config/database.yml