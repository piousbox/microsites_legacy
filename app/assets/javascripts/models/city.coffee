

$(document).ready ->

  Models.City = Backbone.Model.extend
  
    url: ->
      if this.id
        return "/cities/travel-to/" + this.id + ".json"
      else
        return "/cities.json"
        
    initialize: (cityname) ->
      this.id = cityname
      this.fetch()
     
  Models.Cities = Backbone.Collection.extend
    model: Models.City
    
    initialize: ->
      _.bindAll this, 'success', 'error'
      this.fetch
        success: this.success
  
    success: ->
      U.views.cities.index.render()
      