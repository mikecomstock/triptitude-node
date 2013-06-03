class TT.MainView extends Backbone.View
  el: 'body'

  initialize: ->
    @facebookRoot = new TT.Views.Facebook
    @landingView = new TT.Views.Landing
    @planView = new TT.Views.Plan
    @mapView = new TT.MapView

  events: {
    'click .logo': (e) -> TT.Navigate '/'
    'click .plan': (e) -> TT.Navigate 'plan'
    'click .explore': (e) -> TT.Navigate 'explore'
  }

  landing: -> @switchTo @landingView
  plan: -> @switchTo @planView
  explore: -> @switchTo @mapView

  switchTo: (view) ->
    console.log 'MainView.switchTo', view
    if @currentView
      @currentView.$el.fadeOut().promise().done -> view.$el.fadeIn().trigger('activate')
    else
      view.$el.fadeIn().trigger('activate')
    @currentView = view

  bindings: {
    '.plan, .explore': {
      observe: 'user',
      updateView: false,
      visible: (value, options) -> value
      visibleFn: ($el, isVisible, options) ->
        if isVisible then $el.fadeIn() else $el.fadeOut()
    }
  }

  template: """
            <div id="nav1">
              <ul class="inline">
                <li class="plan" style="display:none;"><a href="/plan">Plan <i class="icon-map-marker"></i></a></li>
                <li class="logo"><a href="/">triptitude</a></li>
                <li class="explore" style="display:none;"><a href="/explore"><i class="icon-globe"></i> Explore</a></li>
              </ul>
            </div>
            """

  render: ->
    @$el.html @template
    @stickit(TT.Session)

    @$el.prepend @facebookRoot.render().$el
    @$el.append @landingView.render().$el.hide()
    @$el.append @planView.render().$el.hide()

    # Leaflets expects el to be in the dom, so add it before rendering
    @$el.append @mapView.$el.hide()
    @mapView.render()
    @
