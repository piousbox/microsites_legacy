$(document).ready ->

  #
  # initialization of cities
  #

  MyApp.addInitializer (options) ->
    # Backbone.history.start()

    U.models.cities = new Models.Cities()

    U.views.cities.index = new Views.Cities.Index()
    U.views.trash_view = new Views.TrashView()

  MyApp.start()

  MyApp.right_region.show( U.views.cities.index )
  # MyApp.right_region.show( U.views.trash_view )