class TT.MainView extends Backbone.View
  el: 'body'

  initialize: ->
    @planView = new TT.Views.Plan({ model: @model })
    @mapView = new TT.MapView()
    @loginView = new TT.Views.Login

  events: {

    'click .plan': (e) ->
      e.preventDefault()
      TT.Session.MainRouter.navigate 'plan', { trigger: true }

    'click .explore': (e) ->
      e.preventDefault()
      TT.Session.MainRouter.navigate 'explore', { trigger: true }

  }

  plan: ->
    console.log 'switch to the plan view'
    @mapView.$el.fadeOut()
    @planView.$el.fadeIn()

  explore: ->
    console.log 'switch to the explore view'
    @mapView.$el.fadeIn()
    @planView.$el.fadeOut()

  bindings: {
    '.name': 'name'
  }

  template: """
            <div id="nav1">
              <ul class="inline">
                <li class="plan"><a href="/plan">Plan <i class="icon-map-marker"></i></a></li>
                <li class="logo">triptitude</li>
                <li class="explore"><a href="/explore"><i class="icon-globe"></i> Explore</a></li>
              </ul>
            </div>
            """

  render: ->
    @$el.html @template
    @stickit()

    #@$el.append @loginView.el
    #@loginView.render()

    @$el.append @planView.el
    @planView.render()

    # Leaflets expects el to be in the dom, so add it before rendering
    @$el.append @mapView.el
    @mapView.render()
    @
