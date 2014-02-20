class TT.Views.LoggedIn extends Backbone.View
  id: 'logged-in-view'

  initialize: ->
    @views =
      userHome: new TT.Views.User.Home
      plan: new TT.Views.Plan
      map: new TT.Views.Map

    @listenTo TT.Session.Routers.User, 'route',         => @switchTo @views.userHome
    @listenTo TT.Session.Routers.Plan, 'route',         => @switchTo @views.plan
    @listenTo TT.Session.Routers.Main, 'route:explore', => @switchTo @views.map

    # If they are logged in, but trying to access a not-logged-in view,
    # redirect them to /home
    @listenTo TT.Session.Routers.Main, 'route:landing', =>
      console.log 'redirecting to user home because a person is logged in'
      TT.Navigate('/home')

  events:
    'click .logout': (e) -> FB.logout()

  switchTo: (view) ->
    console.log 'LoggedIn.switchTo', view
    if @currentView
      @currentView.$el.fadeOut().promise().done -> view.$el.fadeIn().trigger('activate')
    else
      view.$el.fadeIn().trigger('activate')
    @currentView = view

  template: """
            <div id="nav1">
              <ul class="list-inline">
                <li class="plan"><a href="/plan">Plan <i class="fa fa-map-marker"></i></a></li>
                <li class="logo"><a href="/home">triptitude</a></li>
                <li class="explore"><a href="/explore"><i class="fa fa-globe"></i> Explore</a></li>
                <li class="logout btn btn-default">Log Out</li>
              </ul>
            </div>
            """

  render: ->
    @$el.html @template
    @$el.append @views.plan.render().$el.hide()
    @$el.append @views.userHome.render().$el.hide()
    @$el.append @views.map.render().$el.hide()
    @
