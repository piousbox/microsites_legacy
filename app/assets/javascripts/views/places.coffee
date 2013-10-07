
$(document).ready ->

  #
  #
  #
  Views.Places.Index = Backbone.View.extend
    el: $("body")

    events:
      'click a.show-place': 'show_place'

    initialize: ->
      _.bindAll this, 'render', 'show_place', 'success'

      this.collection = new Collections.Places(U.models.city.id)
      this.collection.cityname = U.models.city.id
      this.collection.fetch
        success: this.success

    render: ->
      self = this
      str = 'This part of functionality is not yet complete'
      $(" .right-container .places ").append(str)

      _(this.collection.models).each (item) ->
        a = 'a'

    success: ->
      this.render()

    show_place: (item) ->
      U.views.cities.calendar.hide()
      U.views.cities.map.hide()
      rty = $(item.currentTarget).attr('venuename')
      a = new Views.Venues.Show( rty )
