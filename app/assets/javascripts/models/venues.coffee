
$(document).ready ->

  Models.Venue = Backbone.Model.extend

    url: ->
      if @name_seo
        return "/venues/show/" + @name_seo + '.json'
      else if @cityname
        return "/venues/in-city/" + @cityname + ".json"
      else
        return "/venues.json"

    initialize: (item) ->
      if item.name_seo
        @name_seo = item.name_seo
      if item.cityname
        @cityname = item.cityname

      # do I really have to fetch in init?
      @fetch
        success: ->
          MyApp.left_region.show(U.views.venue)


  Collections.Venues = Backbone.Collection.extend
    model: Models.Venue

    url: ->
      if @cityname
        return "/venues/in-city/" + @cityname + ".json"
      else
        return "/venues.json"

    initialize: ( item ) ->
      if item.cityname
        @cityname = item.cityname
      @fetch()
      