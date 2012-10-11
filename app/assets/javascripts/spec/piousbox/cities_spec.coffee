
describe "Cities", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a
    
    div_map = $('<div>').addClass('map')
    div_inner = $("<div>").addClass("inner")
    $('body').append( div_map.append(div_inner) )

  afterEach ->
    $("#main").remove()
    $(".map").remove()
    
  describe "models", ->
    it "there should be city model", ->
      U.models.city = new Models.City()
      expect( U.models.city.url() ).toEqual('/cities')
      
      U.models.city.id = 'rio'
      expect( U.models.city.url() ).toEqual('/cities/travel-to/rio.json')

  describe "views", ->
  
    it 'has map', ->
      $("#cities_show_canvas").remove()
      
      U.views.cities.map = new Views.Cities.Map()
      result = $("#cities_show_canvas")
      expect( result.length > 0 ).toBeTruthy( "map canvas div should reappear" )
  
    it "view profile", ->
      U.views.cities.profile = new Views.Cities.Profile()
      
  
    it "should show calendar", ->
  
      # create the view
      U.views.cities.calendar = new Views.Cities.Calendar('rio')
      
      result = $(".inner .calendar")
      
      setTimeout ->
        expect( result.length > 0 ).toBeTruthy('div.calendar should show up')
        expect( result.innerHTML ).toEqual( 'calendar' )
        
      , 1
      