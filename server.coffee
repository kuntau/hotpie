# coffee server

express = require 'express'
http    = require 'http'
path    = require 'path'
coffee  = require 'coffee-script'

app = express()

app.configure( ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))
)

app.configure 'development', ->
  app.use express.errorHandler()

# Routes
require('./apps/authentication/routes') app
require('./apps/rostering/routes') app

app.get '/', (req, res) ->
  res.render 'index',
    title: 'Index of Home'
    stylesheet: 'style'

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
