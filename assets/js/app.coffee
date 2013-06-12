window.TT =
  Models: {}
  Views:
    User: {}
  Collections: {}
  Routers: {}
  Navigate: (path, trigger = true) -> Backbone.history.navigate(path, trigger)

class TT.Routers.Main extends Backbone.Router
  routes:
    '': 'landing'
    'explore': 'explore'

class TT.Routers.User extends Backbone.Router
  routes:
    'home': 'home'

class TT.Routers.Plan extends Backbone.Router
  routes:
    'plan': 'plan'

# See http://stackoverflow.com/questions/9328513/backbone-js-and-pushstate
# and https://github.com/backbone-boilerplate/backbone-boilerplate/blob/master/app/main.js
$(document).on 'click', 'a[href]:not([data-bypass])', (e) ->
  $this = $(this)
  href = { prop: $this.prop("href"), attr: $this.attr("href") }
  root = location.protocol + "//" + location.host + '/'
  if href.prop.slice(0, root.length) == root
    e.preventDefault()
    Backbone.history.navigate(href.attr, true)

# Some initial setup
$.cookie.json = true # Setup jquery.parse so we can store json objects
$.cookie.path = '/'  # Make cookies global

# A global singleton model
TT.Session = new Backbone.Model

# Create an instance for each router in TT.Routers
TT.Session.Routers = {}
for routerName, router of TT.Routers
  do (routerName) ->
    r = TT.Session.Routers[routerName] = new router
    r.on 'route', (route) -> console.log "#{routerName} router -> #{route}"

$ ->
  new TT.Views.Auth().render()

  if $.cookie 'user'
    # On initial load, we think a user is signed in, so start history
    # and let the routers do their thing without a redirect.
    console.log 'user has cookie, so setting TT.Session'
    console.log $.cookie('user')
    TT.Session.set 'user', new Backbone.Model $.cookie('user')
    Backbone.history.start({ pushState: true })
  else
    # On initial load, we don't have a user, so redirect to root.
    # Tricky because we don't want the router to start working until
    # the user is at the correct url.
    TT.Session.set 'user', null
    console.log 'no user, redirecting to root'
    Backbone.history.start({ pushState: true, silent: true })
    Backbone.history.navigate('', false)
    Backbone.history.loadUrl()
