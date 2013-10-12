
describe "Non-MVCd stuff", ->

  beforeEach ->
    spyOn( $('#accordion'), 'accordion' )

    if $("#accordion").length > 0 
      $("#accordion").accordion()

  afterEach ->
    
 
  describe "accordion", ->
    it 'works', ->
      expect( $('#accordion' ).length ).toBe( 1, 'the element must be there.' )
      expect( $('#accordion').accordion ).toHaveBeenCalled()