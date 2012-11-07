Picture.ly is an image twitter search tool

Create config.js with the following

    ntwitter = require('ntwitter')
    exports.twitter = new ntwitter({
      consumer_key: your_key,
      consumer_secret: your_secret,
      access_token_key: your_token,
      access_token_secret: your_token_secret
    });

Add config.js to your gitignore file
