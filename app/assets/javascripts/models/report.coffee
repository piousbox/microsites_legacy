

$(document).ready ->

  #
  #
  #
  Models.Report = Backbone.Model.extend
  
    url: ->
      if this.id
        return "/reports/view/" + this.id + '.json'
      if this.cityname
        return "/reports/in-city/" + this.cityname + ".json"
      else
        return "/reports"
        
    initialize: ->
      
        
  #
  #
  #
  Collections.Reports = Backbone.Collection.extend
  
    model: Models.Report
    
    url: ->
      if this.cityname
        return "/reports/in-city/" + this.cityname + ".json"
      else 
        return "/reports"
        
    initialize: (cityname) ->
      this.cityname = cityname
      this.fetch
#        success: this.success
#        error: this.error
#        
#    success: ->
#      U.log 'Done loaded'
#      U.views.reports.index.render()
#      # U.views.days.new_day_hide()
#      
#    error: ->
#      U.log 'collection NOT loaded!!!'
      
      
      