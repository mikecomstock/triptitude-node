class TT.Views.Plan extends Backbone.View
  id: 'plan-view'

  initialize: ->
    @packingListView = new TT.PackingListView

  template: """
            <div class="nav2">
              <ul class="inline">
                <li class="current-trip">Name of Current Trip</li>
                <li><a href="plan/itinerary"><i class="icon-list"> Itinerary</i></a></li>
                <li><a href="plan/packing"><i class="icon-briefcase"></i> Packing List</a></li>
                <li><a href="plan/calendar"><i class="icon-calendar"> Calendar</i></a></li>
                <li><a href="plan/suggestions"><i class="icon-lightbulb"></i> Suggestions</a></li>
                <li><a href="plan/settings"><i class="icon-cog"></i> Settings</a></li>
              </ul>
            </div>
            """

  render: ->
    @$el.html @template
    @$el.append @packingListView.el
    @packingListView.render()
    @
