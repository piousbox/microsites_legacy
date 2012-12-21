
$(document).ready ->

  Views.Cities.Map = Backbone.View.extend
  
    el: $("body")
    model: Models.City
       
    initialize: (item) ->
      _.bindAll this, 'render', 'hide'    
  
    hide: ->
      $( '.map-container' ).addClass( 'hide' )
      
    render: ->
      U.views.cities.profile.hide_left()
      $( '.map-container' ).removeClass( 'hide' )
      # str = "<div id='cities_show_canvas'></div>"
      # $('.inner', this.el).html str
      # CanvasOps.cities_show_initialize( U.models.city.get('cityname') )
      
  Views.Cities.Galleries = Backbone.View.extend      
    
  Views.Cities.Calendar = Backbone.Marionette.ItemView.extend
    template: '#city_calendar-template'
    model: Models.City
    
  Views.Cities.Home = Backbone.Marionette.ItemView.extend
    template: '#home-template'
    tagName: 'div'
    id: 'cityHome'
    model: Models.City

    initialize: (item) ->
      @model = item.model

      # put an ad there.
      #$('.right-container .home').ready ->
      #  ad = $('.ad-large-rectangle').html()
      #  $('.right-container .inner').append( ad )

  #
  #
  #
  Views.Cities.RightMenu = Backbone.Marionette.ItemView.extend
    template: '#right_menu-template'
    # tagName: 'div'
    # className: 'menu'

    events:
      'click a.reports_link': 'show_reports'
      'click a.places_link': 'show_venues'
      'click a.galleries_link': 'show_galleries'
      'click a.videos_link': 'show_videos'
      'click a.users_link': 'show_users'

    initialize: (item) ->
      @model = item.model
      _.bindAll @, 'show_reports', 'show_venues', 'show_galleries', 'show_videos', 'show_users', 'deactivate_all'

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
          MyApp.right_region.show U.views.videos.index

    show_users: (item) ->
      @deactivate_all()
      $(item.currentTarget).addClass('active')
      U.models.users.fetch
        success: ->
          MyApp.right_region.show U.views.users.index

    deactivate_all: (item) ->
      while $(".right-menu ul li a.active").length > 0
        _.each $(".right-menu ul li a.active"), (key, value) ->
          item = $(".right-menu ul li a.active").eq(value)
          item.removeClass('active')
      

  #
  #
  #
  Views.Cities.Profile = Backbone.View.extend
  
    el: $('body')
    model: Models.City
    
    events:
      'click a.calendar_link': 'show_calendar'
      'click a.map_link': 'show_map'
      'click a.galleries_link': 'show_galleries'
      'click a.reports_link': 'show_reports'
      'click a.places_link': 'show_places'
      'click a.events_link': 'show_places'
      'click a.people_link': 'show_places'
      'click a.videos_link': 'show_videos'
      
    initialize: (item) ->
      _.bindAll this, 'render', 'show_calendar', 'show_map', 'show_galleries', 'show_reports', 'hide_map', 'hide_left', 'show_videos', 'show_places'
      
    hide_map: ->
      $('.map-container').addClass('hide')
      
    hide_left: ->
      $('.map-container').addClass('hide')
      $('.calendar-container').addClass('hide')
      $('.reports-show').addClass('hide')
      $('.galleries-show').addClass('hide')

    hide_right: ->
      $('.main-content .reports').addClass('hide')
      $('.main-content .galleries').addClass('hide')
      $('.main-content .places').addClass('hide')
      $('.main-content .stories').addClass('hide')
      $('.main-content .events').addClass('hide')
      $('.main-content .people').addClass('hide')
      $('.main-content .videos').addClass('hide')


      $('a.videos_link').removeClass('active')
      $('a.reports_link').removeClass('active')
      $('a.galleries_link').removeClass('active')
      $('a.places_link').removeClass('active')
      $('a.people_link').removeClass('active')
      
    render: ->
      ;
      
    show_galleries: ->
      $('.main-content .galleries').removeClass('hide')
      $('.main-content .reports').addClass('hide')
      
    show_reports: ->
      $('.main-content .galleries').addClass('hide')
      $('.main-content .reports').removeClass('hide')

    show_places: ->
      U.views.cities.profile.hide_right()
      $('.main-content .places').removeClass('hide')

    show_videos: ->
      U.views.cities.profile.hide_right()
      $('.main-content .videos').removeClass('hide')
      $('a.videos_link').addClass('active')

    show_calendar: ->
      U.views.cities.profile.hide_left()
      U.views.cities.calendar.render()
      
    show_map: ->
      $( '#cities_show_canvas' ).removeClass('hide')
      