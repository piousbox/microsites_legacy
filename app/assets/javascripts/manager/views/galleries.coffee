$(document).ready ->

  Manager.Views.Galleries.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_galleries_index_item-template'
    model: Manager.Models.Gallery

    events:
      'click a.manager-galleries-delete': 'galleries_delete'

    initialize: (item) ->
      @a_model = item.model
      console.log @a_model
      _.bindAll @, 'galleries_delete'
      # @model.fetch()

    galleries_delete: (item) ->
      @a_model.fetch
        success: ->
                
      @a_model.mark_as_trash()

          # $(@el).hide()
        
  Manager.Views.Galleries.Index = Backbone.Marionette.CollectionView.extend
    # template: '#manager_galleries_index-template'
    itemView: Manager.Views.Galleries.IndexItem

    initialize: (item) ->
      @collection = U.models.galleries

