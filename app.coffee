
express = require 'express'
app = express()

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

app.use require('connect-assets')()

app.configure 'development', ->
  app.use express.logger('dev')
  # Allow connect-assets to access bower libraries in development
  # (not needed in prod because they get compiled by connect-assets)
  app.use  '/components', express.static(__dirname + '/components')

app.get '/', (req, res) ->
  res.render 'index', { title: 'Home' }

app.listen 5000

