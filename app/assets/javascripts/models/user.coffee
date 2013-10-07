

$(document).ready ->

  Models.User = Backbone.Model.extend
  
    url: ->
      if @username
        return "/users/show/" + @username + ".json"
      else
        return "/users.json"

    initialize: (item) ->
      if item.username
        @username = item.username


  Collections.Users = Backbone.Collection.extend  
    model: Models.User
    
    url: ->
      if @username
        return "/users/show/" + @username + ".json"
      else
        return "/users.json"

    initialize: ( item ) ->
      if item.username
        @username = item.username
      