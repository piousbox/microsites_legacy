
describe "Manager Reports Models Spec", ->

  beforeEach ->

  afterEach ->
    # $("#main").remove()

  describe "models", ->
    it 'has model `report`', ->
      r = new Manager.Models.Report({ name_seo: 'Aaa' })
      expect( r ).toBeDefined()

  describe "collections", ->
    it 'has collection `reports`', ->
      reports = new Manager.Collections.Reports()
      expect( reports ).toBeDefined()

      




