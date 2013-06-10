$(document).ready ->
        
  Manager.Models.Galleries = Backbone.Collection.extend
    url: ->
      return '/en/manager/galleries.json'

    model: Manager.Models.Gallery

    initialize: ->
      _.bindAll @, 'mark_as_trash'

    mark_as_trash: (item) ->
      console.log 'collection is marking as trash'

  Manager.Models.Gallery = Backbone.Model.extend
    url: ->
      return "/en/manager/galleries/view/" + @galleryname + ".json"

    initialize: (item) ->
      @galleryname = item.galleryname
      @fetch()
      _.bindAll @, 'delete', 'mark_as_trash'

    delete: (item) ->
      alert( item )

    mark_as_trash: (item) ->
      console.log( 'marking as trash' )