
$(document).ready ->

  #
  # definition of view sites/newsitems
  #

  Views.Sites.Newsitems = Backbone.Marionette.CollectionView.extend
    # model: Models.Site
    # template: '#cities_index_item-template'
    # itemView: Views.Sites.Newsitem

#    initialize: (item) ->
#      this.collection = U.models.sites.newsitems

  Views.Sites.Newsitem = Backbone.Marionette.ItemView.extend
    # template: '#cities_index_item_trash-template'
