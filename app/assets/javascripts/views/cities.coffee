
$(document).ready ->


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
      
    success: ->
      
      $('.inner', this.el).html "<div class='calendar'>blah blah</div>"
      this.render()
      
    error: ->
      # do nothing
      
    render: ->
      
      # str = "<h3>Report " + this.model.get('name') + ' </h3>'
      # str += "<div class='descr'>" + this.model.get('descr') + ' </div>'
      
      # $('.inner', this.el).html str
      
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
      
    initialize: (item) ->
      _.bindAll this, 'render', 'show_calendar'
      
    render: ->
      ;
      
    show_calendar: ->
      U.views.cities.calendar = new Views.Cities.Calendar()