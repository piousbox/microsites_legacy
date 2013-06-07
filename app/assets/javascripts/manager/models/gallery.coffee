$(document).ready ->
        
  ManagerModels.Galleries = Backbone.Collection.extend

    url: ->
      return '/en/manager/galleries.json'

    model: ManagerModels.Gallery

    initialize: ->
      a = 'a'

  ManagerModels.Gallery = Backbone.Model.extend

    url: ->
      return "/en/manager/galleries/view/" + item.galleryname + ".json"

    initialize: ->
      a = 'a'