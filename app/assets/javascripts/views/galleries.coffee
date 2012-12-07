
$(document).ready ->

  #
  #
  #
  Views.Galleries.Index = Backbone.View.extend
  
    el: $("body")
    model: Models.Gallery    
    events:
      'click a.show-gallery': 'show_gallery'

    initialize: ->
      _.bindAll this, 'render', 'success', 'show_gallery'
      
      this.collection = new Collections.Galleries(U.models.city.id)
      this.collection.cityname = U.models.city.id
      this.collection.fetch
        success: this.success
        error: this.error
      

    render: ->
      self = this

      _(this.collection.models).each (item) ->
        str = '<div class="item">'
        str += '<h3><a href="javascript:void(0);" class="show-gallery" '
        str += 'galleryname="' + item.get('galleryname') + '"'
        str += '>' + item.get('name') + '</a></h3>'
        str += '<img src="' + item.get('photo_url') + '" alt="" />'
        # str += '<ul class="tags"><li>tag 1</li></ul>'
        str += '</div>'

        $(" .main-content .galleries .items ").append(str)

    show_gallery: (item) ->
      U.views.cities.profile.hide_left()
      rty = $(item.currentTarget).attr('galleryname')
      a = new Views.Galleries.Show( rty )

    success: ->
      this.render()

  #
  #
  #
  Views.Galleries.Show = Backbone.View.extend

    el: $("body")
    model: Models.Gallery

    initialize: (item) ->
      _.bindAll this, 'render', 'success'

      this.model = new Models.Gallery(item)
      this.model.id = item
      this.model.fetch
        success: this.success

    success: ->
      this.render()

    render: ->
      str = ''

      _(this.model.get('photo_urls')).each (item) ->
        str += '<img src="' + item + '" alt="" />'

      $(' .galleries-show ', this.el).html str
      $(' .galleries-show ', this.el).removeClass( 'hide' )
