

$(document).ready ->

  if $('.Lmanager').length > 0
      #
      # Collections
      #
      # U.models.venues = new Collections.Venues({ cityname: cityname })
      # U.models.reports = new Collections.Reports({ cityname: cityname })
      # U.models.gallery = new Collections.Gallery({ galleryname: galleryname })
      
      #
      # Views
      #
      U.views.cities.home = new Views.Cities.Home({ model: U.models.city })
      U.views.cities.map = new Views.Cities.Map({ model: U.models.city })
      
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


