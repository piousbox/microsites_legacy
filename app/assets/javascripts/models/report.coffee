

$(document).ready ->

  #
  #
  #
  Models.Report = Backbone.Model.extend
  
    url: ->
      if this.id
        return "/reports/show/" + this.id + ".json"
      else
        return "/reports"
        
    initialize: ->
      
        
  #
  #
  #
  Collections.Reports = Backbone.Collection.extend
  
    model: Models.Report
    
    url: "/reports"
    
    initialize: ->
      this.fetch
        success: this.success
        error: this.error
        
    success: ->
      U.log 'Done loaded'
      U.views.reports.index.render()
      # U.views.days.new_day_hide()
      
    error: ->
      U.log 'collection NOT loaded!!!'
      
      
      