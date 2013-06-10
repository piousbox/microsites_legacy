
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

    it "lets delete model gallery", ->
      expect( 1 ).toEqual( 2 ) # todo
      #
      # post to the spec-fixtures-create endpoint
      m = new Manager.Models.Gallery({ 'galleryname': 'Aaa' })
      expect( m.get('is_trash') ).toEqual( false )
      m.mark_as_trash
      m = new Manager.Models.Gallery({ 'galleryname': 'Aaa' })
      expect( m.get('is_trash') ).toEqual( true )
      # post to the spec-fixtures-destroy endpoint

    it 'has model `photo`', ->
      photo = new Manager.Models.Photo({ 'id': '555' })
      expect( photo ).toBeDefined()

  describe "collections", ->
    it 'has collection `galleries`', ->
      galleries = new Manager.Collections.Galleries()
      expect( galleries ).toBeDefined()

    it 'has collection `gallery`', ->
      gallery = new Manager.Collections.Gallery()
      expect(gallery).toBeDefined()

      




