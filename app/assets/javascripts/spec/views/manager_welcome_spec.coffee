
describe "Manager Welcome Views", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->

  describe "views", ->
    it 'defines views', ->
      # galleries = new Manager.Views.Galleries.Index()
      # expect( galleries ).toBeDefined()
      # gallery = new Manager.Views.Galleries.IndexItem({ 'galleryname': 'Aaa' })
      # expect( gallery ).toBeDefined()

  describe 'templates', ->
    it "make sure they exist", ->
      expect( $('#home_wiki').length ).toEqual(1, 'Home Wiki' )




