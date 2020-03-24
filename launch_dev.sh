#!/bin/bash

#######
# This script is for launching your dev environment and server
# Be sure to have your databases running
#######

### set your app name
export APP_NAME="ruby_demo_app"

export MYSQL_PASSWORD=password

### check tools availability
export DOCKER_VERSION=$(docker --version)
echo "installed Docker version is"$DOCKER_VERSION

export NODE_VERSION=$(node -v)
echo "nodejs version is "$NODE_VERSION

export RUBY_VERSION=$(ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]').0
echo "ruby version is "$RUBY_VERSION

export SQLITE_VERSION=$(sqlite3 --version)
echo "sqlite version is "$SQLITE_VERSION

export RAILS_VERSION=$(rails --version 2> /dev/null)
echo "rails version is "$RAILS_VERSION

### set Ruby in the PATH
export PATH=~/.gem/ruby/$RUBY_VERSION/bin:$PATH

### set environment variable for allowing Ruby to access MySQL
export RUBY_DEMO_APP_DATABASE_PASSWORD=$MYSQL_PASSWORD

cd $APP_NAME
rails server