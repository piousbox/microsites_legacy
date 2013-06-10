$(document).ready ->
        
  Manager.Models.Galleries = Backbone.Collection.extend

    url: ->
      return '/en/manager/galleries.json'

    model: Manager.Models.Gallery

    initialize: ->
      a = 'a'

  Manager.Models.Gallery = Backbone.Model.extend

    url: ->
      return "/en/manager/galleries/view/" + item.galleryname + ".json"

    initialize: ->
      a = 'a'