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

    #console.log TT.Session.get('user')
    #trips = new TT.Views.User.Home.Trips
    #collection: TT.Session.get('user').get('trips')
      #@$el.append trips.render().el

    @

class TT.Views.User.Home.Trips extends Backbone.View
  render: ->
    @$el.html 'test'
    @
