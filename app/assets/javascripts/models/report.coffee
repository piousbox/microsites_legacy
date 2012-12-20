

$(document).ready ->

  Models.Report = Backbone.Model.extend

    url: ->
      if this.name_seo
        return "/reports/" + this.name_seo + '.json'
      if this.cityname
        return "/reports/in-city/" + this.cityname + ".json"
      else
        return "/reports.json"

    initialize: (item) ->
      this.name_seo = item
      this.fetch()

  Models.Reports = Backbone.Collection.extend

    model: Models.Report

    url: ->
      if this.cityname
        return "/reports/in-city/" + this.cityname + ".json"
      else
        return "/reports.json"

    initialize: ( cityname ) ->
      this.cityname = cityname
      this.fetch()
      