console.log 'great, it works'

$ ->
  return
  $map = $('<div>', { style: 'width:100%; height:100%; position: absolute; z-index:-1; top:0; left:0; bottom:0; right:0' }).appendTo $(document.body)
  map = L.map $map[0]
  map.fitWorld()

  # add an OpenStreetMap tile layer
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  map.on 'click', (e) ->
    new L.Marker(e.latlng).addTo map

class TestView extends Backbone.View
  el: 'body'

  render: ->
    console.log 'render'
    @$el.html 'Welcome to Triptitude, with Backbone!'
    @

$ ->
  tv = new TestView()
  tv.render()
