
$(document).ready ->


  #
  #
  #
  Views.Galleries.Index = Backbone.View.extend
  
    el: $(".main-content")
    
    events:
      'click a.delete': 'delete_item'
      
    initialize: (item) ->
      this.model = item
      
      _.bindAll this, 'render', 'delete_item'
      
      this.render()

    render: ->
      str = ''
      
      $('.galleries-index', this.el).append str
      
    delete_item: ->
      U.log 'removing ' + this.model.get('id')
      U.temp2 = this
