
$(document).ready ->

  #
  # definition of view cities/index
  #

  Views.Cities.IndexItem = Backbone.Marionette.ItemView.extend
    model: Models.City
    template: '#cities_index_item-template'

  Views.Cities.IndexItemTrash = Backbone.Marionette.ItemView.extend
    template: '#cities_index_item_trash-template'

  Views.Cities.Index = Backbone.Marionette.CollectionView.extend
    template: '#cities_index-template'
    itemView: Views.Cities.IndexItemTrash
    # collection: Models.Cities