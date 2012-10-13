
describe "Users", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a
    
    div_map = $('<div>').addClass('map')
    div_inner = $("<div>").addClass("inner")
    $('body').append( div_map.append(div_inner) )

  afterEach ->
    # $("#main").remove()
    # $(".map .inner").remove()

  describe "models", ->
    it "should not error out", ->
      expect( false ).toGeTruthy()
    
  describe "views", ->
  
    it "should show resume", ->
      expect( false ).toGeTruthy()
      
    it "should show index", ->
  
      # create the view
      U.views.reports.index = new Views.Reports.Index()
      
      r = U.views.reports.index.collection
      
      setTimeout ->

        expect( r.length > 0 ).toBeTruthy()

        result = $("#main .index li")
        
        expect( result.length > 0 ).toBeTruthy()
        expect( result.length ).toEqual( 10 )   
        
      , 1
      
    it "should show show", ->
      reportname = 'an-example-deploy-rb-file-capistrano'
      U.views.reports.show = new Views.Reports.Show(reportname)
      
      setTimeout ->
        result = $(".map .inner h3")
        expect( result.length > 0 ).toBeTruthy()
        
      , 1