
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
      galleries = new Manager.Views.Galleries.Index()
      expect( galleries ).toBeDefined()
      gallery = new Manager.Views.Galleries.IndexItem({ 'galleryname': 'Aaa' })
      expect( gallery ).toBeDefined()

  describe 'galleries show', ->
    it 'defines collection view `galleries`', ->
      r = new Manager.Views.Gallery galleryname: 'Aaa'
      expect( r ).toBeDefined()

    it 'defines the view `photo`', ->
      ph = new Manager.Views.Photo id: 555
      expect( ph ).toBeDefined()

  describe 'templates', ->
    it "makes sure they exist", ->
      expect( $('#manager_galleries_index-template').length ).toEqual(1, 'galleries index' )
      expect( $('#manager_galleries_index_item-template').length ).toEqual(1, 'galleries index item' )
      expect( $('#manager_galleries_photo-template').length ).toEqual(1, 'galleries photo' )




