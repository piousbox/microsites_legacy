


$(document).ready ->



  #
  #
  #
  Views.Reports.Show = Backbone.View.extend
  
    el: $("body")
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
      
    success: ->
      this.render()
      
    error: ->
      # do nothing
      
    render: ->
      U.views.cities.profile.hide_left()
      
      str = "<h3>Report " + this.model.get('name') + ' </h3>'
      str += "<div class='descr'>" + this.model.get('descr') + ' </div>'
      
      $(' .reports-show ', this.el).html str
      $(' .reports-show ', this.el).removeClass( 'hide' )
      
    show_item: ->
      # alert('show report')
      


  #
  #
  #
  Views.Reports.Index = Backbone.View.extend
  
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
        str += '<ul class="tags"><li>tag 1</li></ul>'
        str += '</div>'
        
        $(" .main-content .reports .items ").append(str)
        
    success: ->
      this.render()

    show_report: (item) ->
      U.views.cities.calendar.hide()
      U.views.cities.map.hide()
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
        a3: a3
        a4: a4
        a5: a5
        work: work
        dream: dream
        
      model.save()
    