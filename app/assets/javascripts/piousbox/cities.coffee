
$(document).ready ->

  if $( ".Lcities" ).length > 0
    city_id = $(".ids").attr('cityname')
    CanvasOps.cities_show_initialize(city_id)

    cityname = $('.ids').attr('cityname')
    U.models.venues = new Models.Venues( cityname )
    U.models.city = new Models.City( cityname )
    U.models.reports = new Models.Reports( cityname )

    MyApp.addInitializer (options) ->
      right_menu = new Views.Cities.RightMenu
        collection: U.models.city

      U.views.reports = new Views.Reports.Index
        collection: U.models.reports

      MyApp.right_menu.show right_menu

    

    U.views.cities.profile = new Views.Cities.Profile( cityname )
    U.views.cities.calendar = new Views.Cities.Calendar()
    U.views.cities.map = new Views.Cities.Map()

    U.views.galleries.index = new Views.Galleries.Index()
    U.views.videos.index = new Views.Videos.Index()

    if $("body#cities_profile").length > 0
      MyApp.addInitializer (options) ->
        venues = new Views.Venues.Index
          collection: U.models.venues

        city_home = new Views.Cities.Home
          collection: U.models.city

        U.views.reports = new Views.Reports.Index
          collection: U.models.reports

        MyApp.right_region.show venues
        MyApp.right_region.show city_home


    MyApp.start {
      cityname: cityname
    }



  if $("body#cities_index").length > 0

    CanvasOps.cities_index_initialize()

    feature_cities_selected = true

    if feature_cities_selected
      CanvasOps.homepage_feature_cities()
    else
      CanvasOps.homepage_all_cities()


    