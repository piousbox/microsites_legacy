
describe "Galleries", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe "models", ->
    it 'has model `gallery`', ->
      gallery = new Manager.Models.Gallery({ 'galleryname': 'Aaa' })
      expect( gallery ).toBeDefined()

    it "lets delete model galelry", ->
      expect(1).toEqual(2)

    it 'has model `photo`', ->
      expect(1).toEqual(2)

  describe "collections", ->
    it 'has collection `galleries`', ->
      galleries = new Manager.Collections.Galleries()
      expect( galleries ).toBeDefined()

    it 'has collection `gallery`', ->
      expect(1).toEqual(2)

      




