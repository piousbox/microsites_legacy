
$(document).ready ->

  #
  #
  #
  Views.Videos.Index = Backbone.View.extend

    el: $("body")
    model: Models.Video
    events:
      'click a.show-video': 'show_video'

    initialize: ->
      _.bindAll this, 'render', 'success', 'show_video'

      this.collection = new Collections.Videos(U.models.city.id)
      this.collection.cityname = U.models.city.id
      this.collection.fetch
        success: this.success
        error: this.error


    render: ->
      self = this

      _(this.collection.models).each (item) ->
        str = '<div class="item">'
        str += '<h3><a href="javascript:void(0);" class="show-video" '
        str += 'name_seo="' + item.get('name_seo') + '"'
        str += '>' + item.get('name') + '</a></h3>'
        str += '<img src="' + item.get('photo_url') + '" alt="" />'
        # str += '<ul class="tags"><li>tag 1</li></ul>'
        str += '</div>'

        $(" .main-content .videos .items ").append(str)

    show_video: (item) ->
      U.views.cities.profile.hide_left()
      rty = $(item.currentTarget).attr('galleryname')
      a = new Views.Videos.Show( rty )

    success: ->
      this.render()

  #
  #
  #
  Views.Videos.Show = Backbone.View.extend

    el: $("body")
    model: Models.Video

    initialize: (item) ->
      _.bindAll this, 'render', 'success'

      this.model = new Models.Video(item)
      this.model.id = item
      this.model.fetch
        success: this.success

    success: ->
      this.render()

    render: ->
      str = ''
      name_seo = this.model.get('name_seo')

      _(this.model.get('photoss')).each (item) ->
        str += '<a href="' + item['large'] + '" rel="lightbox['+galleryname+']"><img src="' + item['thumb'] + '" alt="" /></a>'

      $(' .galleries-show ', this.el).html str
      $(' .galleries-show ', this.el).removeClass( 'hide' )
