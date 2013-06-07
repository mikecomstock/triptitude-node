class TT.Views.Auth extends Backbone.View
  el: 'body'

  initialize: ->
    @facebookRoot = new TT.Views.Facebook
    @views =
      notLoggedIn: new TT.Views.NotLoggedIn
      loggedIn: new TT.Views.LoggedIn

    # TT.Session.set('user') happens right away on page load,
    # so this is used to set the initial logged in/not visibility.
    @listenTo TT.Session, 'change', => @updateVisibility()

  updateVisibility: ->
    if TT.Session.get('user')
      @views.loggedIn.$el.show()
      @views.notLoggedIn.$el.hide()
    else
      @views.loggedIn.$el.hide()
      @views.notLoggedIn.$el.show()

  render: ->
    @$el.append @facebookRoot.render().$el.hide()
    @$el.append @views.notLoggedIn.render().$el.hide()
    @$el.append @views.loggedIn.render().$el.hide()
    @
