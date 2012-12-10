
div_left_container = $('<div>').addClass('left-container')

$(document).ready ->


  #
  #
  #
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
      
  #
  #
  #
  Views.Cities.Galleries = Backbone.View.extend
  
    events:
      'a': 'a'
      
    initialize: (item) ->
      ;
      
    render: ->
      ;
      
    
  #
  #
  #
  Views.Cities.Calendar = Backbone.View.extend
  
    el: $(".left-container")
    model: Models.City
    
    events:
      'click a.trash': 'show_item'
      
    initialize: (item) ->
      _.bindAll this, 'render', 'success', 'error', 'show_item', 'hide'
      
    success: ->
      # this.render()
      
    error: ->
      # do nothing
      
    hide: ->
      $('.calendar-container').addClass('hide')
      
    render: ->
      str = U.models.city.attributes.calendar_frame
      $('.calendar-container', this.el).html str
      $('.calendar-container').removeClass('hide')
      
    show_item: ->
      # alert('show report')
      
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
      