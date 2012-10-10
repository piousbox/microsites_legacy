
$(document).ready ->


  #
  #
  #
  Views.Reports.Show = Backbone.View.extend
  
    el: $(".map")
    
    events:
      'click a.trash': 'show_item'
      
    initialize: (item) ->
    
      this.model = new Models.Report(item)
      
      _.bindAll this, 'render', 'show_item'
      
      this.render()

    render: ->
      
      str = "<li>Report " + this.model.get('name') + ' '
      str += "</li> "
      
      $('.inner', this.el).html str
      
    show_item: ->
      alert('show report')
      


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
      a = new Views.Reports.Show(item)
    
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
    