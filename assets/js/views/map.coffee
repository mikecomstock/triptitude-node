class app.MapView extends Backbone.View
  id: 'map-view'

  render: ->
    map = L.map @el
    map.fitWorld()

    # add an OpenStreetMap tile layer
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    map.on 'click', (e) ->
      new L.Marker(e.latlng).addTo map
    @
