
describe "Videos", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe "views", ->

    it "should show index", ->
      U.models.city = new Models.City('San_Francisco')

      # create the view
      U.views.videos.index = new Views.Videos.Index()

      # fail miserably
      expect( true ).toBeTruthy()