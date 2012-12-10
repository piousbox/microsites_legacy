

$(document).ready ->

  #
  #
  #
  Models.Video = Backbone.Model.extend

    url: ->
      if this.id
        return "/videos/" + this.id + '.json'
      if this.cityname
        return "/videos/in-city/" + this.cityname + ".json"
      else
        return "/videos.json"

    initialize: ->
      a = 'a'

  #
  #
  #
  Collections.Videos = Backbone.Collection.extend

    model: Models.Video

    url: ->
      if this.cityname
        return "/videos/in-city/" + this.cityname + ".json"
      else
        return "/videos"

    initialize: (cityname) ->
      this.cityname = cityname
      this.fetch



