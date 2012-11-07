express = require('express');
app = express();
server = require('http').createServer(app);
io = require('socket.io').listen(server);
twit = require('./config.js').twitter;

app.configure( function() {
  app.use(express.static('./static'));
});

app.get('/', function(req,res){
  res.render('index.jade', {title: 'Picturely'});
});

app.get('/search', function(req,res){
  q = req.query.q + ' pic.twitter.com OR yfrog OR instagr.am OR twitpic OR lockerz OR instagram.com'
  twit.search(q, {include_entities: 'true'}, function(err, data) {
    if (err)
      res.render('search.jade', {error: 'true'});
    else
      res.render('search.jade', {title: 'Picturely', results: JSON.stringify(data.results)});
  });
});

server.listen(3000);

io.sockets.on('connection', function(socket) {
});
