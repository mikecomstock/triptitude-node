class TT.MainView extends Backbone.View
  el: 'body'

  initialize: ->
    @landingView = new TT.Views.Landing
    @facebookRoot = new TT.Views.Facebook
    @planView = new TT.Views.Plan { model: @model }
    @mapView = new TT.MapView
    @loginView = new TT.Views.Login

  events: {

    'click .logo': (e) ->
      e.preventDefault()
      TT.Session.MainRouter.navigate '/', { trigger: true }

    'click .plan': (e) ->
      e.preventDefault()
      TT.Session.MainRouter.navigate 'plan', { trigger: true }

    'click .explore': (e) ->
      e.preventDefault()
      TT.Session.MainRouter.navigate 'explore', { trigger: true }

  }

  landing: ->
    @switchTo @landingView

  plan: ->
    @switchTo @planView

  explore: ->
    @switchTo @mapView

  switchTo: (view) ->
    if @currentView
      @currentView.$el.fadeOut().promise().done -> view.$el.fadeIn().trigger('activate')
    else
      view.$el.fadeIn().trigger('activate')
    @currentView = view

  bindings: {
    '.name': 'name'
  }

  template: """
            <div id="nav1">
              <ul class="inline">
                <li class="plan"><a href="/plan">Plan <i class="icon-map-marker"></i></a></li>
                <li class="logo"><a href="/">triptitude</a></li>
                <li class="explore"><a href="/explore"><i class="icon-globe"></i> Explore</a></li>
              </ul>
            </div>
            """

  render: ->
    @$el.html @template
    @stickit()

    @$el.prepend @facebookRoot.render().$el.hide()
    @$el.append @landingView.render().$el.hide()
    #@$el.append @loginView.render().$el.hide()
    @$el.append @planView.render().$el.hide()

    # Leaflets expects el to be in the dom, so add it before rendering
    @$el.append @mapView.$el.hide()
    @mapView.render()
    @
