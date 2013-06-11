$(document).ready ->
  if $('#manager_galleries_show').length > 0
    galleryname = $('.ids').attr('galleryname')

    U.models.gallery = new Manager.Collections.Gallery
      galleryname: galleryname

    U.views.gallery = new Manager.Views.Gallery()

    U.models.gallery.fetch
      success: ->
        MyApp.manager_region.show( U.views.gallery )

  if $('#manager_galleries_index').length > 0
    U.models.galleries = new Manager.Collections.Galleries()
    U.views.galleries.index = new Manager.Views.Galleries.Index()
    U.models.galleries.fetch
      success: ->
        MyApp.manager_region.show( U.views.galleries.index )