
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
      expect( U.models.city.url() ).toEqual('/cities.json')
      
      U.models.city.cityname = 'rio'
      expect( U.models.city.url() ).toEqual('/cities/travel-to/rio.json')

      # expect( U.models.galleries ).toBeDefined( 'galleries should be defined' )
      # expect( U.models.reports ).toBeDefined( 'reports should be defined' )
      # expect( U.models.venues ).toBeDefined( 'venues should be defined' )
      # expect( U.models.city ).toBeDefined( 'city model should be defined' )

  describe 'globals', ->
    it 'should setup all the globals', ->
      expect( U.trash.sanity ).toEqual( 'saaanty' )
      expect( $('.ids').attr('cityname') ).toEqual( 'San_Francisco' )

  describe "views", ->

    it 'deactivates all', ->
      rio = new Models.City('rio')
      
      n_active_li = $(".right-menu ul li a.active").length
      expect( n_active_li > 1 ).toBeTruthy( 'more than one a.active' )
      view = new Views.Cities.RightMenu
        model: rio

      view.deactivate_all()
      n_active_li_2 = $(".right-menu ul li a.active").length
      expect( n_active_li_2 ).toBe( 0 )

    it 'click galleries, click venues', ->
      rio = new Models.City('rio')
      U.views.cities.right_menu = new Views.Cities.RightMenu( model: rio )

      # expect( U.trash.galleries_link_clicked ).toBeUndefined()
      # U.views.cities.right_menu.show_galleries()
      # expect( U.trash.galleries_link_clicked ).toBeDefined()

      # expect( U.trash.places_link_clicked ).toBeUndefined()
      # U.views.cities.right_menu.show_venues()
      # expect( U.trash.places_link_clicked ).toBeDefined()
  
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

      