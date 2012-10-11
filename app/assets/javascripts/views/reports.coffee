
$(document).ready ->


  #
  #
  #
  Views.Reports.Show = Backbone.View.extend
  
    el: $(".map")
    model: Models.Report
    
    events:
      'click a.trash': 'show_item'
      
    initialize: (item) ->
    
      _.bindAll this, 'render', 'success', 'error', 'show_item'
      
      this.model = new Models.Report(item)
      this.model.id = item
      this.model.fetch
        success: this.success
        error: this.error
      
      _.bindAll this, 'render', 'show_item'
      
      
    success: ->
      this.render()
      
    error: ->
      # do nothing
      
    render: ->
      
      str = "<h3>Report " + this.model.get('name') + ' </h3>'
      str += "<div class='descr'>" + this.model.get('descr') + ' </div>'
      
      $('.inner', this.el).html str
      
    show_item: ->
      # alert('show report')
      


  #
  #
  #
  Views.Reports.Index = Backbone.View.extend
  
    el: $(".main-content .inner")
    
    events:
      'click a.show-report': 'show_report'

    initialize: ->
      
      _.bindAll this, 'render', 'show_report'
      
      this.collection = new Collections.Reports()
      
      this.render()
      
    render: ->
      self = this
      
      _(this.collection.models).each (item) ->
        str = '<div class="item">'
        str += '<h3><a href="javascript:void(0);" class="show-report" '
        str += 'reportname="' + item.get('name_seo') + '"'
        str += '>' + item.get('name') + '</a></h3>'
        str += '<ul class="tags"><li>tag 1</li></ul>'
        str += '</div>'
        
        # $('.items', this.el).html str
        $('.items', this.el).append(str)
        

    show_report: (item) ->
      rty = $(item.currentTarget).attr('reportname')
      a = new Views.Reports.Show( rty )
    
    #
    # trash
    #
    create_day: ->
      U.log 'new day'
      
      date = $("form.new_day input[name='date']").val()
      a1 = $("form.new_day input[name='a1']").val()
      a2 = $("form.new_day input[name='a2']").val()
      
      model = new Models.Day
        date: date
        a1: a1
        a2: a2
      model.save()
    