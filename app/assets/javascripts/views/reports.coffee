$(document).ready ->

  Views.Reports.Show = Backbone.Marionette.ItemView.extend
    template: '#report-template'
    model: Models.Report
  Views.Reports.ShowMap = Backbone.Marionette.ItemView.extend
    template: '#reports-showmap-template'
    model: Models.Report

  Views.Reports.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#report_small-template'
    model: Models.Report

    initialize: ->
      _.bindAll @, 'vote_up', 'vote_down', 'deactivate_all'

    events:
      'click a.up': 'vote_up'
      'click a.down': 'vote_down'

    vote_up: (item) ->
      $(item.currentTarget).parent().children().removeClass('active')
      name_seo = $(item.currentTarget).attr('name_seo')
      $(item.currentTarget).addClass('active')

    vote_down: (item) ->
      $(item.currentTarget).parent().children().removeClass('active')
      name_seo = $(item.currentTarget).attr('name_seo')
      $(item.currentTarget).addClass('active')

    deactivate_all: (item) ->
      $('a.up').removeClass('active')
      $('a.down').removeClass('active')
    

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

          U.views.report_canvas = new Views.Reports.ShowMap
            model: U.models.report
          MyApp.right_region.show( U.views.report_canvas )

          CanvasOps.reports_show()