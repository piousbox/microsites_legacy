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
        
  Manager.Models.Galleries = Backbone.Collection.extend
    url: ->
      return '/en/manager/galleries.json'

    model: Manager.Models.Gallery

    initialize: ->
      a = 'a'