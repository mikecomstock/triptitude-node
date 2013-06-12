class TT.Views.Auth extends Backbone.View
  el: 'body'

  initialize: ->
    @facebookRoot = new TT.Views.Facebook
    @listenTo TT.Session, 'change', @userChanged

  # TT.Session.set('user') happens on initial page load,
  # and whenever facebook status changes.
  userChanged: ->
    @currentView.remove() if @currentView
    if TT.Session.get('user')
      @currentView = new TT.Views.LoggedIn
    else
      @currentView = new TT.Views.NotLoggedIn

    @$el.append @currentView.render().el

  render: ->
    @$el.append @facebookRoot.render().$el.hide()
    @
