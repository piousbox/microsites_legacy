

$(document).ready ->

  #
  #
  #
  Models.Gallery = Backbone.Model.extend
  
    url: ->
      if this.id
        return "/galleries/show/" + this.id + '.json'
      if this.cityname
        return "/galleries/in-city/" + this.cityname + ".json"
      else
        return "/galleries"
        
    initialize: ->
      
        
  #
  #
  #
  Collections.Reports = Backbone.Collection.extend
  
    model: Models.Report
    
    url: ->
      if this.cityname
        return "/galleries/in-city/" + this.cityname + ".json"
      else 
        return "/galleries"
        
    initialize: (cityname) ->
      this.cityname = cityname
      this.fetch


      
      