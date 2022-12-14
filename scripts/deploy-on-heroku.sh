#!/bin/bash

# Deploy Hangullo To heroku
# NOTE: This script is intended to deploy the app for the first time to heroku
# if you run it again make and the app is aleady created on heroku make sure to comment lines 6:29 
APP_NAME=hangullo-staging-app
heroku login --interactive
heroku buildpacks:set heroku/python --app $APP_NAME 
heroku buildpacks:remove https://github.com/wention/BeautifulSoup4.git  --app $APP_NAME 
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku buildpacks:remove --index 1 heroku/nodejs --app $APP_NAME

echo "Please fill in your ROLLBAR_ACCESS_TOKEN"
read -p 'ROLLBAR_ACCESS_TOKEN: ' ROLLBAR_ACCESS_TOKEN
#


if [ -z "${NPM_READ_ONLY_TOKEN}" ]; then
    echo "Please fill in your NPM_READ_ONLY_TOKEN"
    read -p 'NPM_READ_ONLY_TOKEN: ' NPM_READ_ONLY_TOKEN
    heroku config:set NPM_READ_ONLY_TOKEN=$NPM_READ_ONLY_TOKEN --app $APP_NAME
else
    NPM_READ_ONLY_TOKEN = "${NPM_READ_ONLY_TOKEN}"
    heroku config:set NPM_READ_ONLY_TOKEN=$NPM_READ_ONLY_TOKEN --app $APP_NAME
fi

heroku config:set SECRET_KEY="$(openssl rand -base64 64)" --app $APP_NAME
heroku config:set DEBUG="True" --app $APP_NAME
heroku config:set CURRENT_DOMAIN="$APP_NAME.herokuapp.com" --app $APP_NAME
heroku config:set ALLOWED_HOSTS="$APP_NAME.herokuapp.com,localhost" --app $APP_NAME
heroku config:set NPM_CONFIG_PRODUCTION=false --app $APP_NAME
heroku config:set ROLLBAR_ACCESS_TOKEN=$ROLLBAR_ACCSESS_TOKEN --app $APP_NAME

git init 
heroku git:remote --app $APP_NAME
git branch -M main
git add . 
git commit -m "Initial heroku commit"
git push heroku main
heroku open --app $APP_NAME
