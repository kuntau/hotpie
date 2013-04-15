# routes and controller for rostering

roster_l01 = [
  { "servis": 1, "bas": 100, "driver": "Ramli Md Salleh" },
  { "servis": 2, "bas": 148, "driver": "Ramzani Syawal" },
  { "servis": 3, "bas": 107, "driver": "Yazid Ismail" }
  { "servis": 4, "bas": 62, "driver": "Rusleee Abu Samah" }
]

routes = (app) ->
  app.get '/rostering', (req, res) ->
    res.render "#{__dirname}/views/roster",
      title: 'Rostering'
      stylesheet: 'style'
      roster_l01: roster_l01

  app.get '/rostering/:laluan', (req, res) ->
    res.send "rostering " + req.params.laluan

module.exports = routes
