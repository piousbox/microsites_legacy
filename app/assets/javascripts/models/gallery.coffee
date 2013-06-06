

$(document).ready ->

  Models.Gallery = Backbone.Model.extend

    url: ->
      if @galleryname
        return "/galleries/view/" + @galleryname + '.json'
      else if @cityname
        return "/galleries/in-city/" + @cityname + ".json"
      else
        return "/galleries.json"

    initialize: (item) ->
      if item.galleryname
        @galleryname = item.galleryname
      else if item.cityname
        @cityname = item.cityname

      # do I really have to fetch in init?
      # @fetch
      #   success: ->
      #     MyApp.left_region.show(U.views.gallery)


  Collections.Galleries = Backbone.Collection.extend
    model: Models.Gallery

    url: ->
      if @cityname
        return "/galleries/in-city/" + @cityname + ".json"
      else
        return "/galleries.json"

    initialize: (item) ->      
      if item.cityname
        @cityname = item.cityname
              
      