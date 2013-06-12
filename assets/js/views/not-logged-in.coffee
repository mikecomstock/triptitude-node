class TT.Views.NotLoggedIn extends Backbone.View
  id: 'not-logged-in-view'

  template: """
            <h1>triptitude</h1>
            <div class="fb-login-button" data-size="xlarge">Log in with Facebook</div>
            """

  render: ->
    @$el.html @template
    @
