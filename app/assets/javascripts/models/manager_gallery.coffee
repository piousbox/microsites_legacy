$(document).ready ->

  Manager.Models.Gallery = Backbone.Model.extend
    url: ->
      if @galleryname
        return '/en/manager/galleries/' + @galleryname + '.json'
      else
        return '/en/manager/galleries.json'

    initialize: (item) ->
      @galleryname = item.galleryname

  Manager.Models.Galleries = Backbone.Collection.extend
    model: Manager.Models.Gallery

    url: ->
      return "/en/manager/galleries.json"

  Manager.Collections.Gallery = Backbone.Collection.extend
    model: Manager.Models.Photo

    url: ->
      return '/en/manager/galleries/view/' + @galleryname '.json'

    initialize: (item) ->
      @galleryname = item.galleryname