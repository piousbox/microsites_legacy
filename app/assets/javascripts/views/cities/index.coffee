
$(document).ready ->

  #
  # definition of view cities/index
  #

  Views.Cities.IndexItem = Backbone.Marionette.ItemView.extend
    model: Models.City
    template: '#cities_index_item-template'

  Views.Cities.Index = Backbone.Marionette.CollectionView.extend
    template: '#cities_index-template'
    itemView: Views.Cities.IndexItem
