$(document).ready ->
        
  Models.Site = Backbone.Model.extend
    locale: 'en'

    url: ->
      if this.cityname
        return "/"+@locale+"/cities/travel-to/" + this.cityname + ".json"
      else
        return "/"+@locale+"/cities.json"
        
    initialize: (item) ->
      @cityname = item.cityname
      @fetch
        success: ->
          # U.views.cities.home.render()
          # U.views.cities.index.render()
          a = 'a' # nothing
         
