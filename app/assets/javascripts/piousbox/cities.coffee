
$(document).ready ->
  if $( ".Lcities" ).length > 0

    if $( ".ids" ).length > 0
      cityname = $( '.ids' ).attr( 'cityname' )

      #
      # Models
      #
      U.models.city = new Models.City( 'cityname': cityname )
      
      #
      # Collections
      #
      U.models.venues = new Collections.Venues({ cityname: cityname })
      U.models.reports = new Collections.Reports({ cityname: cityname })
      U.models.galleries = new Collections.Galleries({ cityname: cityname })
      U.models.users = new Collections.Users({ cityname: cityname })
      U.models.videos = new Collections.Videos({ cityname: cityname })

      #
      # Views
      #
      U.views.cities.home = new Views.Cities.Home({ model: U.models.city })
      U.views.cities.map = new Views.Cities.Map({ model: U.models.city })
      U.views.cities.right_menu = new Views.Cities.RightMenu({ model: U.models.city })
      U.views.cities.left_menu = new Views.Cities.LeftMenu({ model: U.models.city })
      
      MyApp.start()

      MyApp.right_region.show( U.views.cities.home )
      MyApp.left_region.show( U.views.cities.map )

      MyApp.right_menu.show( U.views.cities.right_menu )
      MyApp.left_menu.show( U.views.cities.left_menu )



  if $("body#cities_index").length > 0
    CanvasOps.cities_index_initialize()

    U.models.cities = new Models.Cities()

    U.views.cities.index = new Views.Cities.Index()
      
    MyApp.start()

    # why is below commented out?
    # MyApp.right_region.show( U.views.cities.index )



  if $("#cities_show_canvas").length > 0
    cityname = $( '#cities_show_canvas' ).attr( 'cityname' )
    U.views.cities.map = new Views.Cities.Map
      model: U.models.city = new Models.City(cityname)

    