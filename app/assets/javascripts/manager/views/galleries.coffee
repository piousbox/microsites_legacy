$(document).ready ->

  Manager.Views.Galleries.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_galleries_index_item-template'
    model: Manager.Models.Gallery

    events:
      'click a.manager-galleries-delete': 'galleries_delete'

    initialize: (item) ->
      _.bindAll @, 'galleries_delete'
        
    galleries_delete: ->
      @model.mark_as_trash( @el )

  Manager.Views.Photo = Backbone.Marionette.ItemView.extend
    template: '#manager_galleries_photo-template'
    model: Manager.Models.Photo

    initialize: (item) ->
      _.bindAll @, 'move', 'delete'

    move: ->

    delete: ->
        
  #
  # collections
  #
  Manager.Views.Galleries.Index = Backbone.Marionette.CollectionView.extend
    # template: '#manager_galleries_index-template'
    itemView: Manager.Views.Galleries.IndexItem

    initialize: (item) ->
      @collection = U.models.galleries

  Manager.Views.Gallery = Backbone.Marionette.CollectionView.extend
    itemView: Manager.Views.Galleries.Photo

    initialize: (item) ->
      @collection = U.models.gallery