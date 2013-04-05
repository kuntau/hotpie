routes = (app) ->
  app.get '/lister', (req, res) ->
    res.end "#{__dirname}"

module.exports = routes