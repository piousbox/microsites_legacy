
$(document).ready ->


  #
  #
  #
  Views.Cities.Map = Backbone.View.extend
  
    el: $(".map")
    model: Models.City
       
    initialize: (item) ->
    
      _.bindAll this, 'render', 'success', 'error'
      
      this.model = U.models.city
      this.render()
      
    success: ->
      this.render()
      
    error: ->
      
    render: ->
      str = "<div id='cities_show_canvas'></div>"
      $('.inner', this.el).html str
      CanvasOps.cities_show_initialize( U.models.city.get('cityname') )
      
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
  
    el: $(".map")
    model: Models.City
    
    events:
      'click a.trash': 'show_item'
      
    initialize: (item) ->
    
      _.bindAll this, 'render', 'success', 'error', 'show_item'
      
      this.model = U.models.city
      this.render()
      
    success: ->
      
      $('.inner', this.el).html "<div class='calendar'>blah blah</div>"
      this.render()
      
    error: ->
      # do nothing
      
    render: ->
      str = this.model.get('calendar_frame')
      $('.inner', this.el).html str
      
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
      
    initialize: (item) ->
      _.bindAll this, 'render', 'show_calendar',  'show_map', 'show_galleries', 'show_reports'
      
    render: ->
      ;
      
    show_galleries: ->
      $('.main-content .galleries').removeClass('hide')
      $('.main-content .reports').addClass('hide')
      
    show_reports: ->
      $('.main-content .galleries').addClass('hide')
      $('.main-content .reports').removeClass('hide')
      
    show_calendar: ->
      U.views.cities.calendar = new Views.Cities.Calendar()
      
    show_map: ->
      U.views.cities.map = new Views.Cities.Map()