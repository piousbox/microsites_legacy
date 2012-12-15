
$(document).ready ->

  Models.Venue = Backbone.Model.extend
    defaults:
      name: 'No Name'

    url: ->
      if this.id
        return "/venues/" + this.id + '.json'
      if this.cityname
        return "/venues/in-city/" + this.cityname + ".json"
      else
        return "/venues.json"


  Models.Venues = Backbone.Collection.extend
    model: Models.Venue

    url: ->
      if this.cityname
        return "/venues/in-city/" + this.cityname + ".json"
      else
        return "/venues.json"

    initialize: (venues) ->
      this.fetch()

