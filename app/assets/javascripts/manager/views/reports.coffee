$(document).ready ->

  Manager.Views.Reports.IndexItem = Backbone.Marionette.ItemView.extend
    template: '#manager_reports_index_item-template'
    model: Manager.Models.Gallery

    events:
      'click a.expand-link': 'expand'

    initialize: (item) ->
      _.bindAll @, 'expand'
      @is_expanded = false

    expand: ->
      if @is_expanded
        @is_expanded = false
        $( '.body-content', @el ).hide( 500 )
      else
        @is_expanded = true
        $('.body-content', @el).show( 500 )

  #
  # collections
  #
  Manager.Views.Reports.Index = Backbone.Marionette.CollectionView.extend
    itemView: Manager.Views.Reports.IndexItem

    initialize: (item) ->
      @collection = U.collections.reports
