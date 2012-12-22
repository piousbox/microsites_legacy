

$(document).ready ->

  Models.City = Backbone.Model.extend
  
    url: ->
      if this.cityname
        return "/cities/travel-to/" + this.cityname + ".json"
      else
        return "/cities.json"

    initialize: (item) ->
      this.cityname = item
      this.fetch
        success: ->
          U.views.cities.home.render()
          U.views.cities.map.show_map()
        
     
  Models.Cities = Backbone.Collection.extend
    model: Models.City
    
    initialize: ->
      _.bindAll @, 'success', 'error'
      @fetch()


      
      