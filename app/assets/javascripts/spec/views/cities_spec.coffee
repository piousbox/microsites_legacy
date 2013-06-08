
describe "Cities Views Spec", ->

  beforeEach ->
    # $('body').attr('id', 'cities_index')

  afterEach ->
    # $('body').attr('id', 'nothing')
    
  describe "templates", ->
    it 'Makes the distinction between Views.Cities.RightMenu and Views.City.RightMenu', ->
      one = new Views.Cities.RightMenu({ 'model': new Models.City('San_Francisco') })
      two = new Views.Cities.IndexRightMenu()
      expect( one ).toBeDefined()
      expect( two ).toBeDefined()
           
  describe 'cities index right menu', ->
    it 'has function deactiveate_all()', ->
      specimen = new Views.Cities.IndexRightMenu()
      expect( specimen.deactivate_all() ).toBeDefined()

    it 'shows cities', ->
      specimen = new Views.Cities.IndexRightMenu()
      expect( specimen.show_cities($ 'body' ) ).toBeDefined()

    it 'shows newsitems', ->
      specimen = new Views.Cities.IndexRightMenu()
      expect( specimen.show_newsitems($ 'body' ) ).toBeDefined()
