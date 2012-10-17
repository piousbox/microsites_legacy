

$(document).ready ->

  #
  #
  #
  Models.City = Backbone.Model.extend
  
    url: ->
      if this.id
        return "/cities/travel-to/" + this.id + ".json"
      else
        return "/cities"
        
    initialize: (cityname) ->
      
      this.id = cityname
      
      _.bindAll this, 'success'      
      
      this.fetch
        success: this.success
        
    success: ->
      ; # nothing
    
        
  #
  #
  #
  Collections.Cities = Backbone.Collection.extend
  
    model: Models.City
    
    url: "/cities"
    
    initialize: ->
      this.fetch
        success: this.success
        error: this.error
        
    success: ->
      U.views.cities.index.render()
      
    error: ->
      ;
      
      