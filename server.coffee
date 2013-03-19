#!C:\Users\User\AppData\Roaming\npm\node_modules\coffee-script\bin coffee

express = require 'express'
coffee  = require 'coffee-script'
http    = require 'http'
path    = require 'path'

app = express()

app.configure( ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))
)

app.configure 'development', ->
  app.use express.errorHandler()

# app.get '/', routes.index
# app.get '/users', user.list

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
