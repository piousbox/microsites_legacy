
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



$(document).ready ->

  Views.Galleries.Show = Backbone.Marionette.ItemView.extend
    template: '#gallery-template'
    model: Models.Gallery
    tagName: 'div'
    className: 'gallery'

  Views.Galleries.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#galleries-small-template'
    model: Models.Gallery
    

  Views.Reports.Index = Backbone.Marionette.CompositeView.extend
    tagName: 'div'
    id: 'reports'
    className: 'list-of'
    template: '#reports-template'
    itemView: Views.Reports.ShowSmall

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.reports').append itemView.el

    events:
      'click a.show-report': 'show_report'

    show_report: (item) ->
      
      name_seo = $(item.currentTarget).attr('name_seo')
      # console.log( U.name_seo )

      U.models.report = new Models.Report({ name_seo: name_seo })

      U.views.report = new Views.Reports.Show
        model: U.models.report

      MyApp.left_region.show U.views.report