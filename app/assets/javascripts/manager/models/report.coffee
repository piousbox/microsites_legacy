$(document).ready ->

  #
  # ordering is important! This preceedes the collection definition.
  #
  Manager.Models.Report = Backbone.Model.extend
    url: ->
      return "/en/manager/reports/view/" + @name_seo + ".json"

    initialize: (item) ->
      _.bindAll @, 'mark_as_trash'
      @name_seo = @get('name_seo')

    mark_as_trash: (el) ->
      @set( 'is_trash', true )
      @save null,
        success: ->
          $(el).hide()
        error: ->
          console.log 'wfh'

  Manager.Collections.Report = Backbone.Collection.extend
    url: ->
      return '/en/manager/reports.json'

    model: Manager.Models.Report
