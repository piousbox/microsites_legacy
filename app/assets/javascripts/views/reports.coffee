
$(document).ready ->

  Views.Reports.Show = Backbone.Marionette.ItemView.extend
    template: '#report-template'
    tagName: 'div'
    className: 'report'

  Views.Reports.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#report-small-template'
    tagName: 'div'
    className: 'report'

  Views.Reports.Index = Backbone.Marionette.CompositeView.extend
    template: '#reports-template'
    itemView: Views.Reports.ShowSmall

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.reports').append itemView.el

    events:
      'click .reports .report h3 a': 'show_report'

    show_report: (item) ->
      U.name_seo = $(item.currentTarget).attr('class')

      U.report_model = new Models.Report()
      U.report_model.id = U.name_seo
      U.report_model.fetch()

      U.report_view = new Views.Reports.Show
        model: U.report_model

      MyApp.left_region.show U.report_view
