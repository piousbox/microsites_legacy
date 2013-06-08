
$(document).ready ->

  #
  # definition of view sites/newsitems
  #

  Views.Sites.Newsitems = Backbone.Marionette.CollectionView.extend
    # model: Models.Site
    template: '#sites_newsitems-template'
    itemView: Views.Sites.Newsitem

#    initialize: (item) ->
#      this.collection = U.models.sites.newsitems

  Views.Sites.Newsitem = Backbone.Marionette.ItemView.extend
    template: '#sites_newsitem-template'
