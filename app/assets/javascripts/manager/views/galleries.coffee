$(document).ready ->

  Manager.Views.Galleries.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_galleries_index_item-template'
    model: Manager.Models.Gallery

    events:
      'click a.manager-galleries-delete': 'galleries_delete'

    initialize: (item) ->
      # @model.fetch
      _.bindAll @, 'galleries_delete'

    galleries_delete: (item) ->
      # alert($(item.currentTarget).attr('galleryname'))

      # send request to delete gallery

      # alert( @el )
      $(@el).hide()
        
  Manager.Views.Galleries.Index = Backbone.Marionette.CollectionView.extend
    template: '#manager_galleries_index-template'
    itemView: Manager.Views.Galleries.IndexItem

    initialize: (item) ->
      @collection = U.models.galleries

