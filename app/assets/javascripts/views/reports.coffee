
$(document).ready ->

  Views.Reports.Show = Backbone.Marionette.ItemView.extend
    template: '#report-template'
    model: Models.Report
    tagName: 'div'
    className: 'report'

  Views.Reports.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#report-small-template'
    model: Models.Report
    

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
      U.models.report.fetch
        success: ->
          U.views.report = new Views.Reports.Show
            model: U.models.report
          MyApp.left_region.show( U.views.report )
