class app.MainView extends Backbone.View
  el: 'body'

  initialize: ->
    @mapView = new app.MapView()

  template: """
            <h1>this is the template</h1>
            <button class="btn btn-primary">Some Button</button>
            """

  render: ->
    @$el.html @template

    # Leaflets expects el to be in the dom, so add it before rendering
    @$el.append @mapView.el
    @mapView.render()
    @
