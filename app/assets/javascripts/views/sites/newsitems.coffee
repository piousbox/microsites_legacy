
$(document).ready ->

  #
  # definition of view sites/newsitems
  #
  # order of the following is important. The itemView preceedes the collectionView
  #
  Views.Sites.Newsitem = Backbone.Marionette.ItemView.extend
    template: '#sites_newsitem-template'
    # model: Models.Site

  #Views.Sites.Newsitems = Backbone.Marionette.CollectionView.extend
  #  # model: Models.Site
  #  template: '#sites_newsitems-template'
  #  itemView: Views.Sites.Newsitem

  Views.Sites.Newsitems = Backbone.Marionette.ItemView.extend
    template: '#sites_newsitems-template'

    initialize: (item) ->
      this.model = item.model
