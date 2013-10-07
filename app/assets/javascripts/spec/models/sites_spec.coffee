
describe "Sites Model Spec", ->

  beforeEach ->
    a = 'a'

  afterEach ->
    a = 'a'
    
  describe "instantiated models", ->
    it "there should be site model", ->
      expect( U.models.site ).toBeDefined()

  describe 'definitions of models', ->
    it 'should have definition of site model', ->
      m = new Models.Site({ domain: 'Aaa', locale: 'en' })
      expect( m ).toBeDefined()

      
           
      