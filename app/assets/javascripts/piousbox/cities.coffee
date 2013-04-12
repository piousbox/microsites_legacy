
$(document).ready ->
  if $( ".Lcities" ).length > 0

    if $( ".ids" ).length > 0
      cityname = $( '.ids' ).attr( 'cityname' )

      #
      # Models
      #
      U.models.city = new Models.City( cityname )
      
      #
      # Collections
      #
      U.models.venues = new Collections.Venues({ cityname: cityname })
      U.models.reports = new Collections.Reports({ cityname: cityname })
      U.models.galleries = new Collections.Galleries({ cityname: cityname })
      U.models.users = new Collections.Users({ cityname: cityname })
      U.models.videos = new Collections.Videos({ cityname: cityname })

      # U.views.cities.calendar = new Views.Cities.Calendar()

      #
      # Views
      #
      U.views.cities.home = new Views.Cities.Home({ model: U.models.city })
      U.views.cities.map = new Views.Cities.Map({ model: U.models.city })
      U.views.cities.right_menu = new Views.Cities.RightMenu({ model: U.models.city })
      U.views.cities.left_menu = new Views.Cities.LeftMenu({ model: U.models.city })

      #
      # app config
      #
      MyApp.addInitializer (options) ->

        if $(".report-name-seo").length > 0
          # name_seo = $(".report-name-seo").attr('report_name_seo')
          # U.models.report = new Models.Report({ name_seo: name_seo })
          # MyApp.left_region.show new Views.Reports.Show
          #   model: U.models.report

        else if $('.galleryname').length > 0
          ;
        else
          MyApp.right_region.show U.views.cities.home
          MyApp.left_region.show U.views.cities.map

        MyApp.right_menu.show U.views.cities.right_menu
        MyApp.left_menu.show U.views.cities.left_menu
      
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

  if $("#cities_show_canvas").length > 0
    cityname = $( '#cities_show_canvas' ).attr( 'cityname' )
    U.views.cities.map = new Views.Cities.Map
      model: U.models.city = new Models.City(cityname)

    