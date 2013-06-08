$(document).ready ->
        
  Models.Site = Backbone.Model.extend
    locale: 'en'

    url: ->
      return "/"+@locale+"/sites/aaa.html.json"
        
    initialize: (item) ->
      @fetch
        success: ->
          # U.views.cities.home.render()
          # U.views.cities.index.render()
          a = 'a' # nothing
         
