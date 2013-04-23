drivers = [
  { "id": 1, "name": "Ramli Zarin",   "bas": 143 },
  { "id": 2, "name": "Ujang Rashid",  "bas": 146 },
  { "id": 3, "name": "Nasir Amir",    "bas": 60 },
  { "id": 4, "name": "Mokhtar Lani",  "bas": 142 },
  { "id": 5, "name": "Saffie Ali",    "bas": 144 }
]

mongoose  = require 'mongoose'
# mongoose.connect "mongodb://localhost/papsb"

AngularSchema = new mongoose.Schema
  id: Number,
  name: String,
  bas:  Number

Angular = mongoose.model 'Angular', AngularSchema

routes = (app) ->
  # intercept routing
  app.param 'id', (req, res, next, id) ->
    Drivers.findOne {id: id}, (err, docs) ->
      req.driver = docs
      # req.driver = docs[0]
      next()

  # list all driver
  app.get '/angular', (req, res) ->
    Angular.find {}, (err, docs) ->
      throw err if err
      res.render "#{__dirname}/views/index",
        title: 'Driver List'
        stylesheet: 'style'
        drivers: docs.sort 'name'

  # new user
  app.get '/driver/new', (req, res) ->
    res.render "#{__dirname}/views/new",
      title: "New Driver"
      stylesheet: 'style'

  # create user
  app.post '/driver', (req, res) ->
    b = req.body
    new Drivers
      id: b.id
      name: b.name
      bas: b.bas
    .save (err, driver) ->
      res.json err if err
      res.redirect '/driver/' + driver.id

  # show driver
  app.get '/driver/:id', (req, res) ->
    res.render "#{__dirname}/views/profile",
      title:  "Biodata of #{req.driver.name}"
      stylesheet:  'style'
      driver: req.driver

  # edit driver
  app.get '/driver/:id/edit', (req, res) ->
    res.render "#{__dirname}/views/edit",
      title: "Edit Driver"
      stylesheet: "style"
      driver: req.driver

  # update driver
  app.put '/driver/:id', (req, res) ->
    b = req.body
    Drivers.update({ id: req.params.id }
      {id: b.id, name: b.name, bas: b.bas}
      (err) -> res.redirect '/driver/' + b.id)

  # delete driver
  app.delete '/driver/:id', (req, res) ->
    Drivers.remove
      id: req.params.id, (err) -> res.redirect '/driver/'

module.exports = routes
