
$(document).ready ->

  Views.Reports.Show = Backbone.Marionette.ItemView.extend
    template: '#report-template'
    model: Models.Report

  Views.Reports.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#report_small-template'
    model: Models.Report
    

  Views.Reports.Index = Backbone.Marionette.CompositeView.extend
    template: '#reports-template'
    itemView: Views.Reports.ShowSmall

    events:
      'click a.show-report': 'show_report'

    initialize: ->
      _.bindAll @, 'show_report', 'appendHtml'

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.reports').append itemView.el

    show_report: (item) ->
      
      if item.name_seo
        name_seo = item.name_seo
      else
        name_seo = $(item.currentTarget).attr('name_seo')

      U.views.cities.left_menu.deactivate_all()
      
      U.models.report = new Models.Report({ name_seo: name_seo })
      U.models.report.fetch
        success: ->
          U.views.report = new Views.Reports.Show
            model: U.models.report
          MyApp.left_region.show( U.views.report )
