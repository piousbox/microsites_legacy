
$(document).ready ->

  Views.Reports.Show = Backbone.Marionette.ItemView.extend
    template: '#report-template'
    tagName: 'div'
    className: 'report'

  Views.Reports.Index = Backbone.Marionette.CompositeView.extend
    tagName: 'div'
    id: 'reports'
    className: 'list-of'
    template: '#reports-template'
    itemView: Views.Reports.Show

    appendHtml: (collectionView, itemView) ->
      collectionView.$('.items').append itemView.el

  #
  # trash
  #
  Views.Reports.IndexOld = Backbone.View.extend
    el: $("body")
    events:
      'click a.show-report': 'show_report'

    initialize: ->
      _.bindAll this, 'render', 'show_report', 'success'
      
      this.collection = new Collections.Reports(U.models.city.id)
      this.collection.cityname = U.models.city.id
      this.collection.fetch
        success: this.success
      
    render: ->
      self = this
      
      _(this.collection.models).each (item) ->
        str = '<div class="item">'
        str += '<h3><a href="javascript:void(0);" class="show-report" '
        str += 'reportname="' + item.get('name_seo') + '"'
        str += '>' + item.get('name') + '</a></h3>'
        str += '<img src="' + item.get('photo_url') + '" alt="" />'
        # str += '<ul class="tags"><li>tag 1</li></ul>'
        str += '</div>'
        
        $(" .right-container .reports .items ").append(str)
        
    success: ->
      this.render()

    show_report: (item) ->
      U.views.cities.calendar.hide()
      U.views.cities.map.hide()
      rty = $(item.currentTarget).attr('reportname')
      a = new Views.Reports.Show( rty )
    