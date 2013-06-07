class TT.Views.NotLoggedIn extends Backbone.View
  id: 'not-logged-in-view'

  initialize: ->
    # If a logged in user tries to access this
    # view, just redirect them to /home.
    @listenTo TT.Session.Routers.Main, 'route:landing', =>
      TT.Navigate('/home') if TT.Session.get('user')

  events:
    'click .log-in': (e) ->
      FB.login (response)->
        # TODO: Do something else if the user doesn't really log in
        TT.Navigate 'home'

  template: """
            <h2>
              <a href="#" class="log-in">Log in with Facebook</a>
            </h2>
            """

  render: ->
    @$el.html @template
    @
