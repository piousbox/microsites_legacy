
$(document).ready ->

  Views.Videos.ShowSmall = Backbone.Marionette.ItemView.extend
    template: '#video_small-template'
    model: Models.Video


  Views.Videos.Index = Backbone.Marionette.CompositeView.extend
    tagName: 'div'
    id: 'videos'
    template: '#videos-template'
    itemView: Views.Videos.ShowSmall

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.items').append itemView.el
    
    events:
      'click a.show-video': 'show_video'

    show_video: (item) ->
      U.views.cities.profile.hide_left()
      rty = $(item.currentTarget).attr('youtube_id')
      a = new Views.Videos.Show( rty )

  
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
      str = '<iframe id="ytplayer" type="text/html" width="640" height="390"
src="http://www.youtube.com/embed/' + this.model.get('youtube_id') + '?autoplay=1&origin=http://piousbox.com"
frameborder="0"/>'

      $(' .videos-show ', this.el).html str
      $(' .videos-show ', this.el).removeClass( 'hide' )
