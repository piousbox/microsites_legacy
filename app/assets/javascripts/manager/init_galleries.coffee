$(document).ready ->
  if $('#manager_galleries_show').length > 0
    U.models.gallery = new Manager.Models.Gallery
    U.views.gallery = new Manager.Views.Gallery()

  if $('#manager_galleries_index').length > 0
    U.models.galleries = new Manager.Collections.Galleries()
    U.views.galleries.index = new Manager.Views.Galleries.Index()
    U.models.galleries.fetch
      success: ->
        MyApp.manager_region.show( U.views.galleries.index )