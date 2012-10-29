
describe "Reports", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a
    
    div_r = $('<div>').addClass('reports')
    div_rr = $('<div>').addClass('items')
    
    div_map = $('<div>').addClass('map')
    div_inner = $("<div>").addClass("inner")
    div_reports_show = $('<div>').addClass('reports-show')
    $('body').append( div_map.append(div_inner) )
    $('body').append( div_reports_show )
    $('body').append( div_r.append(div_rr) )

  afterEach ->
    $("#main").remove()
    $(".map").remove()
    $(".reports-show").remove()
    $(".reports").remove()

  describe "views", ->
  
    it 'should get index for city', ->
      U.models.city = new Models.City('San_Francisco')
      
      U.views.reports.index = new Views.Reports.Index()
      rs = U.views.reports.index.collection
      expect( rs.length > 0 ).toBeTruthy()
      
      _.each(rs.models, (item) ->
        
      )
  
    it "should show index", ->
      U.views.reports.index = new Views.Reports.Index()
      
      r = U.views.reports.index.collection
      
      expect( r.models.length > 0 ).toBe( true, 'index list should be showing' )

      result = $(".reports .items .item")
      
      # expect( result.length ).toEqual( 10, 'index of reports should be showing' )   
        

    it "should show show", ->
      reportname = 'an-example-deploy-rb-file-capistrano'
      $( '.reports-show' ).addClass('hide')
      U.views.reports.show = new Views.Reports.Show(reportname)

      # expect( $(".reports-show h3").length ).toBe( 1, 'report title should show' )
      # expect( $( '.reports-show' ).hasClass('hide') ).toBe( false, 'reports-show should not be hidden' )
      