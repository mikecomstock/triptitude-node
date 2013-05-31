class TT.MapView extends Backbone.View
  id: 'map-view'

  events: {
    # If this view starts hidden, the map gets initialized with a wrong size,
    # so we need to have the map resize itself whenever this view is shown.
    'activate': -> @map.invalidateSize()
  }

  render: ->
    @map = L.map @el, {
      minZoom: 3
    }
    @map.fitWorld()
    # add an OpenStreetMap tile layer
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(@map);

    @map.on 'click', (e) =>
      new L.Marker(e.latlng).addTo @map
    @
