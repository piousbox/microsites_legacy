$(document).ready ->

  Manager.Views.Galleries.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_galleries_index_item-template'
    model: Manager.Models.Gallery

    initialize: (item) ->
      @galleryname = item.galleryname
      @model = new Manager.Models.Gallery
        'galleryname': item.galleryname
      @model.fetch
        success: ->
          @render()
        
  Manager.Views.Galleries.Index = Backbone.Marionette.CollectionView.extend
    template: '#manager_galleries_index-template'
    itemView: Manager.Views.Galleries.IndexItem

