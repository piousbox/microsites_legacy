
describe "Reports", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe "views", ->
  
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
      
      result = $(".map .inner h3")
      expect( result.length > 0 ).toBeTruthy()
      