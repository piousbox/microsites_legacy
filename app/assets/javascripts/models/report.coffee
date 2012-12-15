

$(document).ready ->

  Models.Report = Backbone.Model.extend
  
    url: ->
      if this.id
        return "/reports/view/" + this.id + '.json'
      if this.cityname
        return "/reports/in-city/" + this.cityname + ".json"
      else
        return "/reports.json"
        
    initialize: ->
      a = 'a'

  Models.Reports = Backbone.Collection.extend
    model: Models.Report

    url: ->
      if this.cityname
        return "/reports/in-city/" + this.cityname + ".json"
      else
        return "/reports.json"

    initialize: (venues) ->
      this.fetch()
      