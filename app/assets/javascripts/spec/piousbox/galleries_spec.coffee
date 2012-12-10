
describe "Galleries", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe "views", ->

    it "should show index", ->
      U.models.city = new Models.City()

      # create the view
      U.views.galleries.index = new Views.Galleries.Index()

      r = U.views.galleries.index.collection

      setTimeout ->

        expect( r.length > 0 ).toBeTruthy()

        result = $("#main .index li")

        expect( result.length > 0 ).toBeTruthy()
        expect( result.length ).toEqual( 7 )

      , 1