$(document).ready ->

  Views.Trash = Backbone.Marionette.ItemView.extend
    model: Models.City
    template: '#trash-template'
