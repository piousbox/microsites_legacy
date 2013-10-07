$(document).ready ->

  #
  # initialization of cities
  #
  U.models.cities = new Models.Cities()

  U.views.cities.index = new Views.Cities.Index()

  MyApp.start()

  MyApp.right_region.show( U.views.cities.index )
