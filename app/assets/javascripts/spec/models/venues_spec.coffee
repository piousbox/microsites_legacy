
describe "Venues", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

    div_map = $('<div>').addClass('map')
    div_inner = $("<div>").addClass("inner")
    $('body').append( div_map.append(div_inner) )

  afterEach ->
    $("#main").remove()
    $(".map").remove()

  describe "models", ->
    it "should not error out", ->
      expect( true ).toBeTruthy()

  describe 'instance models', ->
    it 'should have venues', ->
      expect( U.models.venues ).toBeDefined()

    it 'should be sane', ->
      expect( 1 ).toEqual( 1 )

  



