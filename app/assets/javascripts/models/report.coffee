

$(document).ready ->

  Models.Report = Backbone.Model.extend

    url: ->
      if @name_seo
        return "/reports/view/" + @name_seo + '.json'
      else if @cityname
        return "/reports/in-city/" + @cityname + ".json"
      else
        return "/reports.json"

    initialize: (item) ->
      if item.name_seo
        @name_seo = item.name_seo
        #@fetch
        #  success: ->
        #    MyApp.left_region.show( U.views.report )
      if item.cityname
        @cityname = item.cityname



  Collections.Reports = Backbone.Collection.extend
    model: Models.Report

    url: ->
      if @cityname
        return "/reports/in-city/" + @cityname + ".json"
      else
        return "/reports.json"

    initialize: ( item ) ->
      if item.cityname
        @cityname = item.cityname
      