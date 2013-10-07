$(document).ready ->

  Manager.Views.Welcome.Homepage = Backbone.Marionette.ItemView.extend
    template: '#home_wiki'
    # model: Manager.Models.Gallery

    events:
      'click a.manager-galleries-delete': 'galleries_delete'

    initialize: (item) ->
      _.bindAll @, 'galleries_delete'
        
    galleries_delete: ->
      @model.mark_as_trash( @el )
