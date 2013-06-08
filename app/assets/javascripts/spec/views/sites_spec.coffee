
describe "Sites Views Spec", ->

  beforeEach ->
    a = 'a'

  afterEach ->
    a = 'a'
    
  describe "templates", ->
    it "the sites_newsitems template should be present", ->
      expect( $("#sites_newsitems-template").length ).toEqual( 1 )
 
    it 'The sites_newsitem template should be present', ->
      expect( $("#sites_newsitem-template").length ).toEqual( 1 )

  describe 'views', ->
    it 'should let you create sites_newsitems view', ->
      expect( false ).toEqual( true )

    it 'should let you create sites_newsitem view', ->
      expect( false ).toEqual( true )


      
           
      