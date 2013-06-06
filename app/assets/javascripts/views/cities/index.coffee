$(document).ready ->

  Views.Cities.Index = Backbone.Marionette.ItemView.extend
    model: Models.City
    template: '#cities_index-template'

    initialize: (item) ->
      a = 'a' # do nothing
      @model.fetch
        success: ->
          U.views.cities.index.render()