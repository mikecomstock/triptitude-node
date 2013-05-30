class TT.PackingListView extends Backbone.View
  id: 'packing-list-view'

  initialize: ->
    console.log 'packing list view init'
    console.log 'model', @model

  bindings: {
    '.name': 'name'
  }

  template: """
            <h2>Packing List</h2>
            <p><strong>Name:</strong> <span class="name">name goes here</span></p>
            """

  render: ->
    @$el.html @template
    @stickit()
    @
