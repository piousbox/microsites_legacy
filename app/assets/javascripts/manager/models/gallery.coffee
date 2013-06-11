$(document).ready ->

  #
  # ordering is important! This preceedes the collection definition.
  #
  Manager.Models.Gallery = Backbone.Model.extend
    url: ->
      return "/en/manager/galleries/view/" + @id + ".json"

    initialize: (item) ->
      _.bindAll @, 'mark_as_trash'
      @id = @get('galleryname')

    mark_as_trash: (el) ->
      @set( 'is_trash', true )
      @save null,
        success: ->
          $(el).hide()
        error: ->
          console.log 'wfh'

  Manager.Models.Photo = Backbone.Model.extend
    url: ->
      return '/en/manager/photos/'+@id+'.json'

    initialize: (item) ->
      @id = item.id
      _.bindAll @, 'move', 'delete'

    move: ->

    delete: ->
         
  Manager.Collections.Galleries = Backbone.Collection.extend
    url: ->
      return '/en/manager/galleries.json'

    model: Manager.Models.Gallery

  Manager.Collections.Gallery = Backbone.Collection.extend
    url: ->
      return '/en/manager/galleries/photos-in/' + @galleryname + '.json'

    model: Manager.Models.Photo

    initialize: (item) ->
      @galleryname = item.galleryname
