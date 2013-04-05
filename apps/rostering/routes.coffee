# routes and controller for rostering

routes = (app) ->
  app.get '/rostering', (req, res) ->
    res.render "#{__dirname}/views/roster",
      title: 'Rostering'
      stylesheet: 'style'

module.exports = routes