
$(document).ready ->

  Views.Users.Resume = Backbone.View.extend
    el: "body"
    
    events:
      'click .trash': 'nothing'
    
    initialize: ->
      self = this
      
      _.bindAll this, 'render', 'hide', 'update_pad', 'populate_form'
      
      this.model = new Models.User( username: 'piousbox' )
        
      this.render()
      
    nothing: ->
      # do nothing
      
  #
  #
  #
  Views.Users.Pad = Backbone.View.extend
  
    el: "#scratchpad"
    
    events:
      'click .save': 'update_pad'
      
    initialize: ->
      self = this
      
      _.bindAll this, 'render', 'hide', 'update_pad', 'populate_form'
      
      this.model = new Models.User( username: 'piousbox' )
        
      this.render()
      
    render: ->

      if U.views.days.index == undefined
        $("#main").hide()
      else
        U.views.days.index.hide()
        
      $(this.el).show()
      
    hide: ->
      $(this.el).hide()
      return this
      
    update_pad: ->
    
      data =
        pad: $("form.pad textarea").val()
        
      $.post "/pad", data, (incoming) ->
        U.log 'updated pad'
      
    populate_form: (data) ->
      $("#scratchpad textarea").html(data)

  Views.Users.Show = Backbone.Marionette.ItemView.extend
    template: '#user-template'
    model: Models.User

  Views.Users.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#user_small-template'
    model: Models.User

  Views.Users.Index = Backbone.Marionette.CompositeView.extend
    template: '#users-template'
    itemView: Views.Users.ShowSmall

    events:
      'click a.show-user': 'show_user'

    initialize: ->
      _.bindAll @, 'show_user', 'appendHtml'

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.users').append itemView.el

    show_user: (item) ->
      
      if item.username
        name_seo = item.username
      else
        name_seo = $(item.currentTarget).attr('username')

      U.models.user = new Models.User({ username: name_seo })
      U.models.user.fetch
        success: ->
          U.views.user = new Views.Users.Show
            model: U.models.user
          MyApp.left_region.show( U.views.user )






