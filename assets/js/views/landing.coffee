class TT.Views.Landing extends Backbone.View
  id: 'landing-view'

  events: {
    'click .log-in': (e) -> FB.login (response)->
      console.log 'well worked'
      TT.Navigate 'plan'
    'click .log-out': (e) -> FB.logout()
  }

  template: """
            <h2>
              <a href="#" class="log-in">Log in with Facebook</a>
            </h2>
            <a href="#" class="btn log-out">Log Out</a>
            """

  render: ->
    @$el.html @template
    @
