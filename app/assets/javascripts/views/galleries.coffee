
$(document).ready ->

  Views.Galleries.Index = Backbone.Marionette.CompositeView.extend
    tagName: 'div'
    id: 'galleries'
    template: '#galleries-template'
    itemView: Views.Galleries.ShowSmall

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.items').append itemView.el

    sanity: 'index_sanity'

  Views.Galleries.ShowSmall = Backbone.View.extend
    sanity: 'show_small_sanity'

  Views.Galleries.Show = Backbone.Marionette.ItemView.extend
    sanity: 'show_sanity'
    template: '#gallery-template'
    tagName: 'div'
    className: 'gallery'