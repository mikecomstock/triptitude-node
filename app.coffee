
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

