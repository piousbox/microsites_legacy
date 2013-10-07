$(document).ready ->

  Views.Cities.Map = Backbone.Marionette.ItemView.extend
    # model: Models.City
    template: '#city_map-template'
    
    initialize: (item) ->
      _.bindAll this, 'show_map'
      @model = item.model
      # @model.fetch
      #   success: ->
      #     U.views.cities.map.show_map()
      
    show_map: (agrs) ->
      myOptions =
        zoom: 12
        center: new google.maps.LatLng( @model.get('x'), @model.get('y') )
        mapTypeId: google.maps.MapTypeId.ROADMAP

      U.map = new google.maps.Map(document.getElementById("cities_show_canvas"), myOptions)
      
      # data['venues']
      $.each [], (idx, val) ->
        if val["x"] isnt null and val["y"] isnt null
          myLatlng = new google.maps.LatLng(val["x"], val["y"])
          contentString = "<div class='blah blah'>" + "<h4><a href='/venues/" + val["id"] + "'>" + val["name"] + "</a></h4>" + "</div>"
          infowindow = new google.maps.InfoWindow(content: contentString)
          marker = new google.maps.Marker(
            position: myLatlng
            map: U.map
            title: val["name"]
          )
          google.maps.event.addListener marker, "click", ->
            open_infowindow.close()  if open_infowindow
            infowindow.open U.map, marker
            open_infowindow = infowindow
            
      # data['reports']
      $.each [], (key, val) ->
        if val["x"] isnt null and val["y"] isnt null
          myLatlng = new google.maps.LatLng(val["x"], val["y"])
          contentString = "<div class='blah blah'><h4><a href='/reports/"+val["id"]+"'>"+val["name"]+"</a></h4><p>"+val["subhead"]+"</p></div>"
          infowindow = new google.maps.InfoWindow(content: contentString)
          marker = new google.maps.Marker(
            position: myLatlng
            map: U.map
            title: val["name"]
          )
          google.maps.event.addListener marker, "click", ->
            open_infowindow.close()  if open_infowindow
            infowindow.open U.map, marker
            open_infowindow = infowindow

  Views.Cities.Galleries = Backbone.View.extend      
    
  Views.Cities.Calendar = Backbone.Marionette.ItemView.extend
    template: '#city_calendar-template'
    # model: Models.City
    initialize: (item) ->
      @model = item.model

  Views.Cities.Home = Backbone.Marionette.ItemView.extend
    template: '#cities_index-template'
    # model: Models.City

    initialize: (item) ->
      @model = item.model

    onRender: ->
      # put an ad there.
      $('.right-container .inner').ready ->
        ad = $('.ad-large-rectangle').html()
        $('.right-container .inner .home-ad').append( ad )

  Views.Cities.LeftMenu = Backbone.Marionette.ItemView.extend
    template: '#left_menu-template'
    # model: Models.City

    events:
      'click a.map_link': 'show_map'
      'click a.calendar_link': 'show_calendar'

    initialize: (item) ->
      @model = item.model
      _.bindAll @, 'deactivate_all', 'show_map', 'show_calendar'

    show_map: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.city.fetch
        success: ->
          MyApp.left_region.show new Views.Cities.Map
            model: U.models.city

    show_calendar: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.city.fetch
        success: ->
          MyApp.left_region.show new Views.Cities.Calendar
            model: U.models.city

    deactivate_all: (item) ->
      while $(".left-menu ul li a.active").length > 0
        _.each $(".left-menu ul li a.active"), (key, value) ->
          item = $(".left-menu ul li a.active").eq(value)
          item.removeClass('active')

  Views.Cities.RightMenu = Backbone.Marionette.ItemView.extend
    template: '#right_menu-template'
    # I think this is unnecessary if I set the @model in the initializer?
    # model: Models.City
    events:
      'click a.reports_link': 'show_reports'
      'click a.places_link': 'show_venues'
      'click li.galleries_link a': 'show_galleries'
      'click a.videos_link': 'show_videos'
      'click a.users_link': 'show_users'

    initialize: (item) ->
      @model = item.model
      _.bindAll @, 'show_reports', 'show_venues', 'show_galleries', 'show_videos', 'show_users', 'deactivate_all', 'finish_rendering'

    finish_rendering: ->
      if '0' == @model.get('n_galleries').toString()
        $(".galleries-link").css('display', 'none')
        
    show_reports: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.reports.fetch
        success: ->
          MyApp.right_region.show new Views.Reports.Index
            collection: U.models.reports

    show_venues: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.venues.fetch
        success: ->
          MyApp.right_region.show new Views.Venues.Index
            collection: U.models.venues

    show_galleries: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.galleries.fetch
        success: ->
          MyApp.right_region.show new Views.Galleries.Index
            collection: U.models.galleries

    show_videos: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.videos.fetch
        success: ->
          MyApp.right_region.show new Views.Videos.Index
            collection: U.models.videos

    show_users: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.users.fetch
        success: ->
          MyApp.right_region.show new Views.Users.Index
            collection: U.models.users

    deactivate_all: (item) ->
      while $(".right-menu ul li a.active").length > 0
        _.each $(".right-menu ul li a.active"), (key, value) ->
          item = $(".right-menu ul li a.active").eq(value)
          item.removeClass('active')

  Views.Cities.IndexRightMenu = Backbone.Marionette.ItemView.extend
    template: '#cities_index_right_menu-template'
    # I think this is unnecessary if I set the @model in the initializer?
    # model: Models.City
    events:
      'click li.newsitems-link a': 'show_newsitems'
      'click li.cities-link a': 'show_cities'

    initialize: (item) ->
      # so far I think I have no model for this view.
      #
      # @model = item.model
      _.bindAll @, 'show_cities', 'show_newsitems'

    show_cities: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.cities.fetch
        success: ->
          MyApp.right_region.show U.views.cities.index
        
    show_newsitems: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.site.fetch
        success: ->
          MyApp.right_region.show( U.views.sites.newsitems )

    deactivate_all: (item) ->
      while $(".right-menu ul li a.active").length > 0
        _.each $(".right-menu ul li a.active"), (key, value) ->
          item = $(".right-menu ul li a.active").eq(value)
          item.removeClass('active')
