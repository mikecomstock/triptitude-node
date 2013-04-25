
express = require 'express'
app = express()

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

app.use require('connect-assets')()

app.use express.logger('dev')

app.get '/', (req, res) ->
  res.render 'index', { title: 'Home' }

app.listen 5000

