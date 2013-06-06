$(document).ready ->

  #
  # initialization of cities
  #
  U.models.cities = new Models.Cities()
  
  U.views.cities.index = new Views.Cities.Index
    model: U.models.cities

  MyApp.addInitializer (options) ->
    a = 'a' # do nothing

  MyApp.start

  MyApp.right_region.show( U.views.cities.index )