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

    events:
      'click input.action-move': 'move'

    initialize: (item) ->
      _.bindAll @, 'move', 'delete'

    move: ->
      # console.log 'view manager/photo move()'
      new_gallery_id = $(@el).find('form.to-move select option:selected')[0].value
      # console.log new_gallery_id
      @model.doMove({ el: @el, gallery_id: new_gallery_id })

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
    itemView: Manager.Views.Photo

    initialize: (item) ->
      @collection = U.models.gallery