$(document).ready ->
  # models
  U.models.galleries = new ManagerModels.Galleries()

  # views
  U.views.galleries.index = new ManagerViews.Galleries.Index()

  # init
  U.models.galleries.fetch
    success: ->
      MyApp.main_region.show( U.views.galleries.index )