
describe "Reports", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a
    
    div_map = $('<div>').addClass('map')
    div_inner = $("<div>").addClass("inner")
    div_reports_show = $('<div>').addClass('reports-show')
    $('body').append( div_map.append(div_inner) )
    $('body').append( div_reports_show )

  afterEach ->
    $("#main").remove()
    $(".map").remove()
    $(".reports-show").remove()

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
      
      expect( r.length > 0 ).toBe( true, 'index list should be showing' )

      result = $("#main .index li")
      
      expect( result.length ).toEqual( 'index or reports should be showing' )   
        

    it "should show show", ->
      reportname = 'an-example-deploy-rb-file-capistrano'
      $( '.reports-show' ).addClass('hide')
      U.views.reports.show = new Views.Reports.Show(reportname)

      expect( $(".reports-show h3").length ).toBe( 1, 'report title should show' )
      expect( $( '.reports-show' ).hasClass('hide') ).toBe( false, 'reports-show should not be hidden' )
      