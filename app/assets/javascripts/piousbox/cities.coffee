
$(document).ready ->
  if $( ".Lcities" ).length > 0

    if $( ".ids" ).length > 0
      cityname = $('.ids').attr('cityname')
      # CanvasOps.cities_show_initialize(cityname)

      #
      # Models
      #
      U.models.city = new Models.City( cityname )
      # U.models.venue = new Models.Venue({})
      U.models.report = new Models.Report({})
      # U.models.gallery = new Models.Gallery({})
      # U.models.video = new Models.Video({})

      #
      # Collections
      #
      # U.models.venues = new Collections.Venues({ cityname: cityname })
      U.models.reports = new Collections.Reports({ cityname: cityname })
      U.models.galleries = new Collections.Galleries({ cityname: cityname })
      # U.models.videos = new Collections.Videos({ cityname: cityname })

      # U.views.cities.profile = new Views.Cities.Profile( cityname )
      # U.views.cities.calendar = new Views.Cities.Calendar()
      # U.views.cities.map = new Views.Cities.Map()

      #
      # Views
      #
      U.views.cities.home = new Views.Cities.Home({ model: U.models.city })
      U.views.cities.right_menu = new Views.Cities.RightMenu({ model: U.models.city })
      # U.views.venues.index = new Views.Venues.Index({ collection: U.models.venues })
      # U.views.venue = new Views.Venues.Show({ model: U.models.venue })
      U.views.reports.index = new Views.Reports.Index({ collection: U.models.reports })
      # U.views.report = new Views.Reports.Show({ model: U.models.report })
      U.views.galleries.index = new Views.Galleries.Index({ collection: U.models.galleries })
      # U.views.gallery = new Views.Galleries.Show({ model: U.models.gallery })
      # U.views.videos.index = new Views.Videos.Index({ collection: U.models.videos })
      # U.views.video = new Views.Videos.Show({ model: U.models.video })


      #
      # app config
      #
      MyApp.addInitializer (options) ->
        MyApp.right_region.show U.views.cities.home
        MyApp.right_menu.show U.views.cities.right_menu
      
      MyApp.start
        city: U.models.city
        cityname: cityname



  if $("body#cities_index").length > 0

    CanvasOps.cities_index_initialize()

    feature_cities_selected = true

    if feature_cities_selected
      CanvasOps.homepage_feature_cities()
    else
      CanvasOps.homepage_all_cities()


    