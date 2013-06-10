$(document).ready ->

  Manager.Views.Galleries.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_galleries_index_item-template'
    model: Manager.Models.Gallery
        
  Manager.Views.Galleries.Index = Backbone.Marionette.CollectionView.extend
    template: '#manager_galleries_index-template'
    itemView: Manager.Views.Galleries.IndexItem

