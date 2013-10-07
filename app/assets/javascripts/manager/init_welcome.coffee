$(document).ready ->

  if $('body#manager_welcome_homepage').length > 0
    # U.collections.reports = new Manager.Collections.Reports()
    # U.views.reports.index = new Manager.Views.Reports.Index()
    # U.collections.reports.fetch
    #   success: ->
    #     MyApp.manager_region.show( U.views.reports.index )
    U.views.welcome.homepage = new Manager.Views.Welcome.Homepage()
    MyApp.manager_region.show( U.views.welcome.homepage )