window.TT = {
  Models: {}
  Views: {}
  Navigate: (path) -> Backbone.history.navigate(path, true)
}

class TT.MainRouter extends Backbone.Router
  routes: {
    "plan": -> TT.Session.MainView.plan()
    "explore": -> TT.Session.MainView.explore()
    "": -> TT.Session.MainView.landing()
  }

$ ->
  console.log 'document ready'
  TT.Session = new Backbone.Model
  TT.Session.MainRouter = new TT.MainRouter
  TT.Session.MainView = new TT.MainView
  TT.Session.MainView.render()

  Backbone.history.on 'route', (router, name, args) ->
    console.log('route triggered', router, name, args)

  #Backbone.history.start({ pushState: true })

  # See http://stackoverflow.com/questions/9328513/backbone-js-and-pushstate
  # and https://github.com/backbone-boilerplate/backbone-boilerplate/blob/master/app/main.js
  $(document).on 'click', 'a[href]:not([data-bypass])', (e) ->
    $this = $(this)
    href = { prop: $this.prop("href"), attr: $this.attr("href") }
    root = location.protocol + "//" + location.host + '/'
    if href.prop.slice(0, root.length) == root
      e.preventDefault()
      #Backbone.history.navigate(href.attr, true)

