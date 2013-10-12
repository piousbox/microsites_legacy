
describe "Sanity", ->

  beforeEach ->
    a = 'a'

  afterEach ->
    a = 'a'
 
  describe "sanity", ->
    it 'of everything', ->
      expect( true ).toBeTruthy()