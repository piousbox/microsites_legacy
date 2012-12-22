
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
      console.log 'videos.show' 
      rty = $(item.currentTarget).attr('youtube_id')
      console.log rty
      U.models.video = new Models.Video({ youtube_id: rty })
      U.models.video.fetch
        success: ->
          U.views.video = new Views.Videos.Show
            model: U.models.video
          MyApp.left_region.show( U.views.video )
  
  Views.Videos.Show = Backbone.Marionette.ItemView.extend
    model: Models.Video
    template: '#video-template'
