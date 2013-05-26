// Generated by CoffeeScript 1.6.2
(function() {
  var app, express;

  express = require('express');

  app = express();

  app.configure(function() {
    app.set('views', __dirname + '/views');
    return app.set('view engine', 'jade');
  });

  app.use(require('connect-assets')());

  app.use('/components', express["static"](__dirname + '/components'));

  app.configure('development', function() {
    return app.use(express.logger('dev'));
  });

  app.get('/', function(req, res) {
    return res.render('index', {
      title: 'Home'
    });
  });

  app.listen(5000);

}).call(this);
