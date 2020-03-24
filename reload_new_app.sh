#!/bin/bash

### set your app name
export APP_NAME="ruby_demo_app"

export MYSQL_PASSWORD=password

# ### setting database.yml
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

# ### start rails server
rails server

cd ..

#######
# for stopping the databases
#######
# cd development
# ### stop docker DB
# docker-compose down
# cd ..

#######
# for uninstalling rails if needed
#######
# gem uninstall rails
# gem uninstall railties
# gem uninstall -i /usr/share/rubygems-integration/all rails
# gem uninstall -i /usr/share/rubygems-integration/all railties
