
describe "Sites Model Spec", ->

  beforeEach ->
    a = 'a'

  afterEach ->
    a = 'a'
    
  describe "models", ->
    it "there should be site model", ->
      expect( U.models.site ).toBeDefined()

      
           
      