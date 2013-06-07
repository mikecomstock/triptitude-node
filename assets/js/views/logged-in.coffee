class TT.Views.LoggedIn extends Backbone.View
  id: 'logged-in-view'

  initialize: ->
    @views =
      userHome: new TT.Views.User.Home
      plan: new TT.Views.Plan
      map: new TT.Views.Map

    @listenTo TT.Session.Routers.User, 'route', => @switchTo @views.userHome
    @listenTo TT.Session.Routers.Trip, 'route', => @switchTo @views.plan
    @listenTo TT.Session.Routers.Main, 'route:explore', => @switchTo @views.map

  events:
    'click .logout': (e) -> FB.logout()

  switchTo: (view) ->
    console.log 'LoggedIn.switchTo', view
    if @currentView
      @currentView.$el.fadeOut().promise().done -> view.$el.fadeIn().trigger('activate')
    else
      view.$el.fadeIn().trigger('activate')
    @currentView = view

  bindings:
    '.plan, .explore':
      observe: 'user',
      updateView: false,
      visible: (value, options) -> value
      visibleFn: ($el, isVisible, options) ->
        if isVisible then $el.fadeIn() else $el.fadeOut()

  template: """
            <div id="nav1">
              <ul class="inline">
                <li class="plan"><a href="/plan">Plan <i class="icon-map-marker"></i></a></li>
                <li class="logo"><a href="/home">triptitude</a></li>
                <li class="explore"><a href="/explore"><i class="icon-globe"></i> Explore</a></li>
                <li class="logout">Log Out</li>
              </ul>
            </div>
            """

  render: ->
    @$el.html @template
    @$el.append @views.plan.render().$el.hide()
    @$el.append @views.userHome.render().$el.hide()
    @$el.append @views.map.render().$el.hide()
    @
