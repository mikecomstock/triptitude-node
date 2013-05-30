
express = require 'express'
app = express()

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

app.use require('connect-assets')()

# Allow connect-assets to access bower libraries in development
# (not needed in prod because they get compiled by connect-assets)
app.use  '/components', express.static(__dirname + '/components')
app.use  '/img', express.static(__dirname + '/components/bootstrap/img')
app.use  '/font', express.static(__dirname + '/components/font-awesome/build/assets/font-awesome/font')

# Match everything else to index, since Backbone manages routes
app.get '/*', (req, res) ->
  res.render 'index', { title: 'Home' }

app.configure 'development', ->
  app.use express.logger('dev')

app.listen 5000

