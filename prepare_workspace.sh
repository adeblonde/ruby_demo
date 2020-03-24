#!/bin/bash

### set your app name
export APP_NAME="ruby_demo_app"

### set your databases parameters - won't be critical for next parts, you can keep default values
export POSTGRESQL_PASSWORD=postgres_password
export POSTGRESQL_USER=$APP_NAME
export POSTGRESQL_DB=postgres_password

export MYSQL_ROOT_PASSWORD=password
export MYSQL_DATABASE=${APP_NAME}_db
export MYSQL_USER=$APP_NAME
export MYSQL_PASSWORD=password

### install dependencies
OS=$(uname)
echo "OS is " $OS
if [[ $OS != "Linux" ]]
then
    echo "not a Linux kernel"
    ./dependencies_macos.sh
    export PATH="/usr/local/opt/ruby/bin:$PATH"
else
	echo "Ubuntu"
	./dependencies_ubuntu.sh
fi

export RUBY_VERSION=$(ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]').0

### set Ruby in the PATH
export PATH=~/.gem/ruby/$RUBY_VERSION/bin:$PATH

### install rails
gem install --user-install rails

### check tools availability
echo "ruby version is "$RUBY_VERSION

export DOCKER_VERSION=$(docker --version)
echo "installed Docker version is"$DOCKER_VERSION

export NODE_VERSION=$(node -v)
echo "nodejs version is "$NODE_VERSION

export SQLITE_VERSION=$(sqlite3 --version)
echo "sqlite version is "$SQLITE_VERSION

export RAILS_VERSION=$(rails --version 2> /dev/null)
echo "rails version is "$RAILS_VERSION

### install good version of bundler
gem install --user-install bundler:1.17.3

## install sqlite v3 gem
gem install --user-install sqlite3

### install mysql gem
gem install --user-install mysql2 -v 0.5.3

### install pg gem
gem install --user-install pg -v '1.2.3'

### create new app folder
# rails new $APP_NAME -d mysql

#######
# IMPORT OF EXISTING APP
# please delete the following folders and files :
# APP_NAME/app
# APP_NAME/config
# APP_NAME/db
# APP_NAME/Gemfile
# then please copy/paste from your own project the following folders and file :
# YOUR_APP/app
# YOUR_APP/config
# YOUR_APP/db
# YOUR_APP/Gemfile
# YOUR_APP/Capfile
#######

### creation of database servers
tools/set_docker_compose.sh $APP_NAME
cd development
### start docker DB
docker-compose up -d
### WARNING
### wait for dockers to be up and running
### please adapt to your own situation, if 5 seconds is not enough
sleep 5
cd ..

### setting databases
mysql_query="CREATE USER IF NOT EXISTS ${MYSQL_USER} IDENTIFIED BY '${MYSQL_PASSWORD}' ;"
mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
for env in development test production
do
mysql_query="CREATE DATABASE IF NOT EXISTS ${APP_NAME}_${env};"
mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
mysql_query="GRANT ALL PRIVILEGES ON ${APP_NAME}_${env}.* TO ${MYSQL_USER};"
echo $mysql_query
mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
done

### setting database.yml
tools/set_database_config.sh $APP_NAME

cd $APP_NAME

### set environment variable for allowing Ruby to access MySQL
export RUBY_DEMO_APP_DATABASE_PASSWORD=$MYSQL_PASSWORD

### update gems
bundle update
bundle install

### setup of database in Ruby app
rake db:create
rake db:migrate

### install webpacker
rails webpacker:install

# ### start rails server
rails server

# cd ..

# #######
# # for stopping the databases
# #######
# # cd development
# # ### stop docker DB
# # docker-compose down
# # cd ..

# #######
# # for uninstalling rails if needed
# #######
# # gem uninstall rails
# # gem uninstall railties
# # gem uninstall -i /usr/share/rubygems-integration/all rails
# # gem uninstall -i /usr/share/rubygems-integration/all railties