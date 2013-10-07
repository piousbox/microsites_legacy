describe "Manager Reports Views", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe 'templates', ->
    it "makes sure templates exist", ->
      expect( $('#manager_reports_index-template').length ).toEqual(1, 'reports index' )
      expect( $('#manager_reports_index_item-template').length ).toEqual(1, 'reports index item' )

  describe 'functionality', ->
    it 'expands body', ->
      u = new Manager.Views.Reports.IndexItem
      m = new Manager.Models.Report({ name_seo: 'Aaa' })
      u.model = m

      ; # body tag is hidden
      ; # expand
      ; # body tag is shown

      # misc assertions
      expect( u.expand ).toBeDefined()

    it 'collapses body', ->
      ;




