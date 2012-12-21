
$(document).ready ->

  Views.Venues.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#venue_small-template'
    model: Models.Venue

  Views.Venues.Show = Backbone.Marionette.ItemView.extend
    template: '#venue-template'
    model: Models.Venue
    tagName: 'div'
    className: 'venue'

    events:
      'click a.click-me': 'clickMe'

    clickMe: ->
      a = 'a'

    initialize: (item) ->
      this.addMapPoint( item )

    addMapPoint: (item) ->
      m = item.model

      if m.get('x') isnt null and m.get('y') isnt null
        myLatlng = new google.maps.LatLng(m.get('x'), m.get('y'))
        contentString = "<div class='blah blah'>" + "<h4><a href='/venues/" + m.get('id') + "'>" + m.get('name') + "</a></h4>" + "</div>"
        infowindow = new google.maps.InfoWindow(content: contentString)
        marker = new google.maps.Marker(
          position: myLatlng
          map: U.map
          title: m.get('name')
        )
        google.maps.event.addListener marker, "click", ->
          open_infowindow.close()  if open_infowindow
          infowindow.open U.map, marker
          open_infowindow = infowindow

  Views.Venues.Index = Backbone.Marionette.CompositeView.extend
    tagName: 'div'
    id: 'venues'
    className: 'list-of'
    template: '#venues-template'
    itemView: Views.Venues.ShowSmall

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.items').append itemView.el
