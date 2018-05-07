# Gymshare

![](https://i.imgur.com/nyfVXJ2.png)

This is Gymshare - a platform for sharing gym workout plans.  
It is deployed on Heroku : (you should make API call to this, not accessing via browser):  http://secure-reaches-51922.herokuapp.com/ 

## How to start this

This mainly acts as a backend for API call from our mobile app and Telegram (chat bot).  
It is developed and run on Ruby 2.3+ with Postgres as database system.

Make sure you have Ruby and Postgres on your machine.

First, install dependency with : `bundle install`  
Second, create database with: `bundle exec rake db:create`  
Third, apply database migration: `bundle exec rake db:migrate`  
Now you are ready to run the server: `bundle exec rails s`  

Also, if you want to have chat bot, please provide a token via environment variable. It is used in `lib/bot/bot_server.rb` as `ENV['TELEGRAM_TOKEN']`

## API docs

I am very sorry I don't have time to write a API doc for this. For now running `bundle exec rake routes` will expose all routes that you can access. 


