
describe "Galleries", ->

  beforeEach ->

  afterEach ->
    # $("#main").remove()

  describe "models", ->
    it 'has model `gallery`', ->
      gallery = new Manager.Models.Gallery({ 'galleryname': 'Aaa' })
      expect( gallery ).toBeDefined()

    it "lets delete model gallery", ->
      expect( false ).toBe( true, 'todo' )

    it 'has model `photo`', ->
      photo = new Manager.Models.Photo({ id: 555 })
      expect( photo ).toBeDefined()

  describe "collections", ->
    it 'has collection `galleries`', ->
      galleries = new Manager.Collections.Galleries()
      expect( galleries ).toBeDefined()

    it 'has collection `gallery`', ->
      gallery = new Manager.Collections.Gallery()
      expect(gallery).toBeDefined()

      




