class TT.PackingListView extends Backbone.View
  id: 'packing-list-view'

  initialize: ->
    console.log 'packing list view init'
    console.log 'model', @model

  bindings: {
    '.name': 'name'
  }

  sessionBindings: {
    '.user-name': {
      observe: 'user',
      onGet: (value, options) ->
        if value then value.get('name') else 'no one because no one is logged in'
    }
  }

  template: """
            <h2>Packing List for <span class="user-name"></span></h2>
            <p><strong>Name:</strong> <span class="name">name goes here</span></p>
            """

  render: ->
    @$el.html @template
    @stickit(TT.Session, @sessionBindings)
    @
