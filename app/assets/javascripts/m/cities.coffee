$(document).ready ->

  #
  # initialization of cities
  #
  U.views.cities.index = new Views.Cities.Index()
  U.models.cities = new Models.Cities()
  
  MyApp.addInitializer (options) ->

  MyApp.start

  MyApp.right_region.show( U.views.cities.index )