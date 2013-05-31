window.TT = {
  Models: {}
  Views: {}
}

m = new Backbone.Model { name: 'mike' }

class TT.MainRouter extends Backbone.Router
  routes: {

    "plan": ->
      console.log 'route: plan'
      TT.Session.interval = setInterval -> m.set 'name', (new Date).getSeconds() , 1000
      TT.Session.MainView.plan()

    "explore": ->
      console.log 'route: explore'
      clearInterval TT.Session.interval
      TT.Session.MainView.explore()

    "": ->
      console.log 'route: root'
      TT.Session.MainView.landing()
  }

$ ->
  TT.Session = new Backbone.Model
  TT.Session.MainRouter = new TT.MainRouter
  TT.Session.MainView = new TT.MainView { model: m }
  TT.Session.interval = setInterval -> m.set 'name', (new Date).getSeconds() , 1000

  TT.Session.MainView.render()

  Backbone.history.start({ pushState: true })

