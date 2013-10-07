

$(document).ready ->

  #
  #
  #
  Models.Place = Backbone.Model.extend

    url: ->
      if this.id
        return "/venues/" + this.id + '.json'
      if this.cityname
        return "/venues/in-city/" + this.cityname + ".json"
      else
        return "/venues.json"

    initialize: ->
      a = 'a'

  #
  #
  #
  Collections.Places = Backbone.Collection.extend

    model: Models.Place

    url: ->
      if this.cityname
        return "/venues/in-city/" + this.cityname + ".json"
      else
        return "/venues"

    initialize: (cityname) ->
      this.cityname = cityname
      this.fetch



