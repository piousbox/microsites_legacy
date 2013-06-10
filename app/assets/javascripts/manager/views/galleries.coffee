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
        
  Manager.Views.Galleries.Index = Backbone.Marionette.CollectionView.extend
    # template: '#manager_galleries_index-template'
    itemView: Manager.Views.Galleries.IndexItem

    initialize: (item) ->
      @collection = U.models.galleries

