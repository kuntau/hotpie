drivers = [
  { "id": 1, "name": "Ramli Zarin",   "bas": 143 },
  { "id": 2, "name": "Ujang Rashid",  "bas": 146 },
  { "id": 3, "name": "Nasir Amir",    "bas": 60 },
  { "id": 4, "name": "Mokhtar Lani",  "bas": 142 },
  { "id": 5, "name": "Saffie Ali",    "bas": 144 }
]

get_driver_name = (id) ->
  driver.name for driver in drivers when driver.id is id

get_driver_bio  = (id) ->
  driver for driver in drivers when driver.id is id

mongoose  = require 'mongoose'
mongoose.connect "mongodb://localhost/papsb"

DriverSchema = new mongoose.Schema
  id: Number,
  name: String,
  bas:  Number

Drivers = mongoose.model 'Drivers', DriverSchema

routes = (app) ->
  app.param 'id', (req, res, next, id) ->
    Drivers.find {id: id}, (err, docs) ->
      req.driver = docs[0]
      next()

  app.get '/driver', (req, res) ->
    Drivers.find {}, (err, docs) ->
      res.render "#{__dirname}/views/index",
        title: 'Driver List'
        stylesheet: 'style'
        drivers: docs

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

  app.get '/driver/:id', (req, res) ->
    # Drivers.findOne {id: req.params.id}, (err, driver) ->
    res.render "#{__dirname}/views/profile",
      title:  "Biodata of #{req.driver.name}"
      # title:  "Biodata of driver"
      stylesheet:  'style'
      driver: req.driver

  # app.get '/driver/:id', (req, res) ->
  #   id = parseInt(req.params.id)
  #   name = get_driver_name parseInt(id, 10)
  #   driver = get_driver_bio parseInt(id, 10)
  #   res.render "#{__dirname}/views/profile",
  #     title:  "Biodata of #{driver[0].name}"
  #     stylesheet:  'style'
  #     driver: driver

  app.get '/driver/:id/edit', (req, res) ->
    res.send 'Editing driver n0 ' + req.params.id

module.exports = routes
