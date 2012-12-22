
$(document).ready ->

  Views.Venues.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#venue_small-template'
    model: Models.Venue

  Views.Venues.Show = Backbone.Marionette.ItemView.extend
    template: '#venue-template'
    model: Models.Venue

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
    template: '#venues-template'
    itemView: Views.Venues.ShowSmall

    events:
      'click a.show-venue': 'show_venue'

    initialize: ->
      _.bindAll @, 'appendHtml', 'show_venue'

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.items').append itemView.el

    show_venue: (item) ->
      if item.name_seo
        name_seo = item.name_seo
      else
        name_seo = $(item.currentTarget).attr('name_seo')

      U.models.venue = new Models.Venue({ name_seo: name_seo })
      U.models.venue.fetch
        success: ->
          U.views.venue = new Views.Venues.Show
            model: U.models.venue
          MyApp.right_region.show( U.views.venue )
