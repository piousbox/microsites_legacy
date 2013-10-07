

$(document).ready ->

  Models.Video = Backbone.Model.extend

    url: ->
      if @youtube_id
        return "/videos/view/" + @youtube_id + '.json'
      if this.cityname
        return "/videos/in-city/" + this.cityname + ".json"
      else
        return "/videos.json"

    initialize: (item) ->
      if item.youtube_id
        @youtube_id = item.youtube_id
      if item.cityname
        @cityname = item.cityname

  Collections.Videos = Backbone.Collection.extend
    model: Models.Video

    url: ->
      if this.cityname
        return "/videos/in-city/" + this.cityname + ".json"
      else
        return "/videos.json"

    initialize: (item) ->
      if item.cityname
        @cityname = item.cityname

      



