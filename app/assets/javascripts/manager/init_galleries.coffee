$(document).ready ->
  # models
  U.models.galleries = new Manager.Models.Galleries()

  # views
  U.manager.views.galleries.index = new Manager.Views.Galleries.Index()
  U.views.trash = new Views.Trash()

  # init
  U.models.galleries.fetch
    success: ->
      # MyApp.manager_region.show( U.manager.views.galleries.index )
      MyApp.manager_region.show( U.views.trash )