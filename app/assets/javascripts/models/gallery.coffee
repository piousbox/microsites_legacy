

$(document).ready ->

  Models.Gallery = Backbone.Model.extend

    url: ->
      if @name_seo
        return "/galleries/view/" + @name_seo + '.json'
      else if @cityname
        return "/galleries/in-city/" + @cityname + ".json"
      else
        return "/galleries.json"

    initialize: (item) ->
      _.bindAll @, 'success', 'error'

      if item.name_seo
        @name_seo = item.name_seo
      if item.cityname
        @cityname = item.cityname

      # do I really have to fetch in init?
      @fetch
        success: ->
          MyApp.left_region.show(U.views.gallery)


  Collections.Galleries = Backbone.Collection.extend
    model: Models.Gallery

    url: ->
      if @cityname
        return "/galleries/in-city/" + @cityname + ".json"
      else
        return "/galleries.json"

    initialize: ( item ) ->
      _.bindAll @, 'success', 'error'
      
      if item.cityname
        @cityname = item.cityname
      @fetch()
      
      