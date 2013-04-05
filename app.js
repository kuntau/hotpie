
/**
 * Module dependencies.
 */


var express = require('express')
  , http = require('http')
  , path = require('path')
  , coffee = require('coffee-script');

var app = express();

// localhost:3000/login
app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon('public/favicon.ico'));
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
  console.log(__dirname);
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

// Routes
require('./apps/authentication/routes')(app);
require('./apps/lister/routes')(app);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
