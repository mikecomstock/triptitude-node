class TT.Views.User.Home extends Backbone.View
  id: 'user-home'

  sessionBindings: {
    '.user-name': {
      observe: 'user',
      onGet: (value, options) ->
        if value then value.get('name') else ''
    }
  }

  template: """
            <h2>User Home</h2>
            Hi <span class="user-name"></span>!
            """

  render: ->
    @$el.html @template
    @stickit(TT.Session, @sessionBindings)
    @
