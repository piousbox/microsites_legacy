$(document).ready ->

  if $('body#manager_reports_index_all_public').length > 0
    U.collections.reports = new Manager.Collections.Reports()
    U.views.reports.index = new Manager.Views.Reports.Index()
    U.collections.reports.fetch
      success: ->
        MyApp.manager_region.show( U.views.reports.index )
        