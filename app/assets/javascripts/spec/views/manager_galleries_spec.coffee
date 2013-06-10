
describe "Manager Galleries Views", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe "views", ->
    it 'defines views', ->
      galleries = new Views.ManagerGalleries()
      expect( galleries ).toBeDefined()
      gallery = new Views.ManagerGallery({ 'galleryname': 'Aaa' })
      expect( gallery ).toBeDefined()





