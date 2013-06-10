$(document).ready ->
  # models
  U.models.galleries = new Manager.Models.Galleries()

  # views
  U.views.galleries.index = new Manager.Views.Galleries.Index()

  # init
  U.models.galleries.fetch
    success: ->
      MyApp.manager_region.show( U.views.galleries.index )