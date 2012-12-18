
describe "Cities", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a
    
    div_left_container = $('<div>').addClass('left-container')
    div_reports_show = $('<div>').addClass('reports-show')
    div_calendar_container = $('<div>').addClass('calendar-container') 
    div_map_container = $('<div>').addClass('map-container')
    div_map = $('<div>').addClass('map')
    div_inner = $("<div>").addClass("inner")
    $('body').append( div_left_container.append(div_inner.append(div_calendar_container)) )
    $('body').append( div_map_container )
    $('body').append( div_reports_show )
    
    U.views.cities.profile = new Views.Cities.Profile('rio')

  afterEach ->
    $("#main").remove()
    $(".map").remove()
    $(".left-container").remove()
    $(".right-container").remove()
    $(".map-container").remove()
    
  describe "models", ->
    it "there should be city model", ->
      U.models.city = new Models.City()
      expect( U.models.city.url() ).toEqual('/cities')
      
      U.models.city.id = 'rio'
      expect( U.models.city.url() ).toEqual('/cities/travel-to/rio.json')

  describe "views", ->
  
    it 'click galleries, show galleries', ->
      expect( false ).toBeTruthy()
  
    it 'hide left', ->
      U.views.cities.profile.hide_left()
      expect( $('.map-container').hasClass('hide') ).toBe( true, 'hide map' )
      expect( $('.calendar-container').hasClass('hide') ).toBe( true, 'hide calendar' )
      expect( $('.reports-show').hasClass('hide') ).toBe( true, 'hire reports show' )
  
    it 'has map', ->
      
      U.views.cities.map = new Views.Cities.Map()
      result = $(".map-container")
      expect( result.length > 0 ).toBeTruthy( "map canvas div should reappear" )
  
    it 'map can hide', ->
      $( '.map-container' ).removeClass( 'hide' )
      expect( $('.map-container').hasClass('hide') ).toBe( false )
      
      U.views.cities.map.hide()
      
      expect( $('.map-container').hasClass('hide') ).toBe( true )
      
    it "view profile", ->
      U.views.cities.profile = new Views.Cities.Profile()
      
      
    it 'shows map, hides calendar', ->
      # first, it is calendar shows, map does not show.
      $('.map-container').addClass( 'hide' )
      expect( $('.map-container').hasClass('hide') ).toBe( true, 'map container is initially hidden' )
      expect( $('.calendar-container').hasClass('hide') ).toBe( false, 'calendar is visible' )
      
      # click map
      U.views.cities.map.render()
      
      # map shows, calendar does not show
      expect( $('.map-container').hasClass('hide') ).toBe( false, 'map is visible' )
      expect( $('.calendar-container').hasClass('hide') ).toBe( true, 'calendar is invisible' )
      
      
    it "should show calendar", ->
      U.views.cities.calendar = new Views.Cities.Calendar('rio')
      
      result = $(".calendar-container")

      expect( result.length > 0 ).toBeTruthy('calendar container should show up')

      