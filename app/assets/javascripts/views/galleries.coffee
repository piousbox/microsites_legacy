
$(document).ready ->

  Views.Galleries.Index = Backbone.Marionette.CompositeView.extend
    tagName: 'div'
    id: 'galleries'
    template: '#galleries-template'
    itemView: Views.Galleries.ShowSmall

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.items').append itemView.el

  Views.Galleries.Show = Backbone.Marionette.ItemView.extend
    template: '#gallery-template'
    model: Models.Gallery
    tagName: 'div'
    className: 'gallery'

  Views.Galleries.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#gallery_small-template'
    model: Models.Gallery
    