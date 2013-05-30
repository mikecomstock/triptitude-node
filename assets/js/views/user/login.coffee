class TT.Views.Login extends Backbone.View

  className: 'modal hide fade'

  events: {
    'click .log-in': (e) ->
      e.preventDefault()
      FB.login()

    'click .log-out': (e) ->
      e.preventDefault()
      FB.logout()
  }

  bindings: {
    '.name': {
      observe: 'user',
      onGet: (value, options) ->
        if value then value.get('name') else 'not logged in'
    }
  }

  template: """
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3>Facebook Login Modal</h3>
            </div>
            <div class="modal-body">
              <p class="name"></p>
            </div>
            <div class="modal-footer">
             <div class="fb-login-button">
              <a href="#" class="btn log-in">Log In</a>
              <a href="#" class="btn log-out">Log Out</a>
            </div>
            """
  render: ->
    @$el.html @template
    @stickit(TT.Session)
    @$el.modal({ keyboard: false })
    @
