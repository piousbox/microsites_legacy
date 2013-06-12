$(document).ready ->

  Manager.Views.Reports.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_reports_index_item-template'
    model: Manager.Models.Gallery

    events:
      'click a.manager-galleries-delete': 'galleries_delete'

    initialize: (item) ->
      _.bindAll @, 'galleries_delete'
        
    galleries_delete: ->
      @model.mark_as_trash( @el )

  #
  # collections
  #
  Manager.Views.Reports.Index = Backbone.Marionette.CollectionView.extend
    itemView: Manager.Views.Reports.IndexItem

    initialize: (item) ->
      @collection = U.collections.reports
