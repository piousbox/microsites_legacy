
describe "Manager Reports Views", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe 'templates', ->
    it "makes sure they exist", ->
      expect( $('#manager_reports_index-template').length ).toEqual(1, 'reports index' )
      expect( $('#manager_reports_index_item-template').length ).toEqual(1, 'reports index item' )




