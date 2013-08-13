drivers_array = [
  { "id": 1, "name": "Ramli Zarin",   "bas": 143 },
  { "id": 2, "name": "Ujang Rashid",  "bas": 146 },
  { "id": 3, "name": "Nasir Amir",    "bas": 60 },
  { "id": 4, "name": "Mokhtar Lani",  "bas": 142 },
  { "id": 5, "name": "Saffie Ali",    "bas": 144 }
]

get_driver_bio  = (id, opt = all) ->
  if opt is id
    driver.id for driver in drivers when driver.id is id
  else if opt is name
    driver.name for driver in drivers when driver.id is id
  else if opt is bas
    driver.bas for driver in drivers when driver.id is id
  else
    driver for driver in drivers when driver.id is id

mongoose  = require 'mongoose'
mongoose.connect "mongodb://localhost/papsb"

EmployeeSchema = new mongoose.Schema
  id: Number,
  ic: String,
  name: String,
  bas:  Number

Employees = mongoose.model 'Employees', EmployeeSchema

routes = (app) ->
  # intercept routing
  app.param 'id', (req, res, next, id) ->
    Employees.findOne {id: id}, (err, docs) ->
      req.driver = docs
      next()

  # list all driver
  app.get '/driver', (req, res) ->
    Employees.find {}, (err, docs) ->
      throw err if err
      res.render "#{__dirname}/views/index",
        title: 'Driver List'
        stylesheet: 'style'
        drivers: docs.sort '-name'

  # new user
  app.get '/driver/new', (req, res) ->
    res.render "#{__dirname}/views/new",
      title: "New Driver"
      stylesheet: 'style'

  # create user
  app.post '/driver', (req, res) ->
    b = req.body
    new Employees
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
    Employees.update({ id: req.params.id }
      {id: b.id, name: b.name, bas: b.bas}
      (err) -> res.redirect '/driver/' + b.id)

  # delete driver
  app.delete '/driver/:id', (req, res) ->
    Employees.remove
      id: req.params.id, (err) -> res.redirect '/driver/'

module.exports = routes
