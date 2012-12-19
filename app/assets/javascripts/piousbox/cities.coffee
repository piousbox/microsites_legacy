
$(document).ready ->

  if $( ".Lcities" ).length > 0
    city_id = $(".ids").attr('cityname')
    cityname = $('.ids').attr('cityname')

    CanvasOps.cities_show_initialize(city_id)

    U.models.city = new Models.City( cityname )
    U.models.venues = new Models.Venues( cityname )
    U.models.reports = new Models.Reports( cityname )
    U.models.galleries = new Models.Galleries( cityname )

    MyApp.addInitializer (options) ->
      right_menu = new Views.Cities.RightMenu({ collection: U.models.city })
      MyApp.right_menu.show right_menu

      # U.views.reports = new Views.Reports.Index({ collection: U.models.reports })
      # U.views.venues = new Views.Venues.Index({ collection: U.models.venues })

      

    U.views.cities.profile = new Views.Cities.Profile( cityname )
    U.views.cities.calendar = new Views.Cities.Calendar()
    U.views.cities.map = new Views.Cities.Map()

    U.views.galleries.index = new Views.Galleries.Index
      collection: U.models.galleries

    U.views.videos.index = new Views.Videos.Index
      collection: U.models.videos

    U.views.reports.index = new Views.Reports.Index
      collection: U.models.reports

    U.views.venues.index = new Views.Venues.Index
      collection: U.models.venues

    if $("body#cities_profile").length > 0

      MyApp.addInitializer (options) ->

        # venues = new Views.Venues.Index
        #   collection: U.models.venues
        # MyApp.right_region.show venues

        city_home = new Views.Cities.Home
          collection: U.models.city
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


    