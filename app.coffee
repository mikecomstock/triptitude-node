
express = require 'express'
app = express()

# Bower assets go in assets/bower, so we need to add assets/bower here, otherwise
# connect-assets won't be able to find the files.
app.use require('connect-assets')(
  {
    paths: ['assets/js', 'assets/bower', 'assets/css'],
  }
)

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

# Allow connect-assets to access bower libraries in development
# (not needed in prod because they get compiled by connect-assets)
app.use '/bower', express.static(__dirname + '/assets/bower')
app.use '/img', express.static(__dirname + '/assets/bower/bootstrap/img')
app.use '/fonts', express.static(__dirname + '/assets/bower/font-awesome/fonts')
app.use '/leaflet', express.static(__dirname + '/assets/bower/leaflet-0.7.2')
app.use '/assets/leaflet-0.7.2/images', express.static(__dirname + '/assets/bower/leaflet-0.7.2/images')

# See https://developers.facebook.com/docs/facebook-login/getting-started-web/
# and also /assets/js/views/facebook.coffee
app.get '/channel.html', (req, res) ->
  cache_expire = 60*60*24*365
  res.setHeader 'Pragma', 'public'
  res.setHeader 'Cache-Control', "max-age=#{cache_expire}"
  res.setHeader 'Expires', new Date(Date.now() + cache_expire).toUTCString()
  res.send '<script src="//connect.facebook.net/en_US/all.js"></script>'

# Match everything else to index, since Backbone manages routes
app.get '/*', (req, res) ->
  res.render 'index', { title: 'Home' }

app.configure 'development', ->
  app.use express.logger('dev')

app.listen 5000

