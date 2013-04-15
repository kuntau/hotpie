drivers_true =
  '001':
    "id"  : "001"
    "name": "Ramli Zarin"
    "bus": 143
  '002':
    "id"  : "002"
    "name": "Ujang Rashid"
    "bus": 146
  '003':
    "id"  : "003"
    "name": "Nasir Amir"
    "bus": 60

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

routes = (app) ->
  app.get '/driver', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: 'Driver List'
      stylesheet: 'style'
      drivers: drivers

  app.get '/driver/:id', (req, res) ->
    id = parseInt(req.params.id)
    name = get_driver_name parseInt(id, 10)
    driver = get_driver_bio parseInt(id, 10)
    # res.send 'driver ' + "requested id is " + id + " and name is " + name
    res.render "#{__dirname}/views/profile",
      title:  "Biodata of #{driver[0].name}"
      stylesheet:  'style'
      driver: driver

  app.get '/driver/:id/edit', (req, res) ->
    res.send 'Editing driver n0 ' + req.params.id

module.exports = routes
