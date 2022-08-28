#!/bin/bash

# INSTALL HANGULLO DB
#
#
# Activate the virtual env after installation:
#
#    workon hangullo
#
# This script is designed to be idempotent--running it multiple times
# should not be a problem.
#

# DB Configuration Variables
db_user='hangullo'
db_pass='97w-ttk^md=pk@+%$l9r2kw49-9#7(3r-!$=gx(u**%lb5@1q='
db_name='hangullo_db'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    # Install system requirements
    sudo apt-get update
    # Install PostgreSQL
    which psql
    if [ "$?" ]; then
        echo "Postgres is already installed"
    else
        sudo apt install postgresql postgresql-contrib -y
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    # WIP
    which brew
    if ! [ "$?" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "##### Updating Brew..."
    brew update
    which psql:
    if ! [ "$?" ]; then
        brew install postgresql
    fi
elif [[ "$OSTYPE" == "win32" ]]; then
    # Windows
    # WIP
    echo "WIP"
else
    echo "Unknown Operating System!"
fi

# Install Postgres, create database, and grant privs
sudo_p_user='postgres'
if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo_p_user=$(whoami)
fi

echo "##### postresql is installed"
echo "##### Creating database: $db_name"
sudo -u $sudo_p_user createdb $db_name
echo "##### Creating user: $db_user"
sudo -u $sudo_p_user psql -c "CREATE USER $db_user WITH PASSWORD '$db_pass';"
echo "##### Giving user permission to the database"
sudo -u $sudo_p_user psql -c "GRANT ALL PRIVILEGES ON DATABASE $db_name to $db_user;"
