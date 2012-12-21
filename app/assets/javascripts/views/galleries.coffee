
$(document).ready ->

  Views.Galleries.Show = Backbone.Marionette.ItemView.extend
    template: '#gallery-template'
    model: Models.Gallery
    # tagName: 'div'
    # className: 'report'

  Views.Galleries.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#gallery-small-template'
    model: Models.Gallery
    

  Views.Galleries.Index = Backbone.Marionette.CompositeView.extend
    # tagName: 'div'
    # className: 'list-of'
    template: '#galleries-template'
    itemView: Views.Galleries.ShowSmall

    events:
      'click a.show-gallery': 'show_gallery'

    initialize: ->
      _.bindAll @, 'show_gallery', 'appendHtml'

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.galleries').append itemView.el

    show_gallery: (item) ->
      console.log 'showing gallery'
      
      if item.galleryname
        name_seo = item.galleryname
      else
        name_seo = $(item.currentTarget).attr('galleryname')

      U.models.gallery = new Models.Gallery({ galleryname: name_seo })
      U.models.gallery.fetch
        success: ->
          U.views.gallery = new Views.Galleries.Show
            model: U.models.gallery
          MyApp.left_region.show( U.views.gallery )
