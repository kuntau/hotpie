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

require("app/controllers/pages")(app)
require("app/controllers/css")(app)

app.use express.static(config.staticDir)

app.use (req, res, next) ->
  next new errors.NotFound req.path

app.use (error, req, res, next) ->
  console.log "Error handler middleware", error
  if error instanceof errors.NotFound
    res.render "errors/error404"
  else
    res.render "errors/error502"

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
