# coffee server

express = require 'express'
http    = require 'http'
path    = require 'path'
coffee  = require 'coffee-script'
stylus  = require 'stylus'
nib     = require 'nib'

app = express()

app.configure( ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use stylus.middleware(
    src: __dirname + '/views'
    dest: __dirname + '/public'
    compile: ( str, path ) ->
      stylus( str )
        .set( 'filename', path  )
        .set( 'compress', true  )
        .use( nib() )
        .import( 'nib' )
  )
  # app.use stylus.middleware __dirname + '/public'
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
require('./apps/lister/routes') app
require('./apps/rostering/routes') app

app.get '/', (req, res) ->
  res.render 'index',
    title: 'Index of Home'
    stylesheet: 'style'

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
