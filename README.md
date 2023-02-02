# Mr Resibo
Basic Line Bot that responds to specific keywords. Using Sinatra as the Web Framework, Heroku and the Line Messaging API.

### Initial Setup
Install dependencies using Bundler
```
bundle install
```
Clone the repo
```
git clone git@github.com:yusuke0127/mr-resibo-bot.git
```
To deploy to Heroku,
Create the Heroku app
```
heroku login
heroku create [NAME_OF_THE_BOT]
```
Then push
```
heroku push heroku main
```
To configure the environment variables on Heroku
```
heroku config:set LINE_CHANNEL_SECRET=[CHANGE_THIS_TO_YOUR_LINE_CHANNEL_SECRET]
heroku config:set LINE_CHANNEL_TOKEN=[CHANGE_THIS_TO_YOUR_LINE_ACCESS_TOKEN]
``` 
For local development, enable `dotenv-rails` gem then run `bundle install` 

Mr Resibo should be up and running!

### Debugging
Check Heroku logs
```
heroku logs
```

### References
[Line Messaging API](https://developers.line.biz/en/docs/messaging-api/)

[Sinatra](https://github.com/sinatra/sinatra)
