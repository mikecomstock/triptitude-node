
express = require 'express'
app = express()


app.get '/', (req, res) ->
  res.send 'Triptitude'


app.listen 5000

