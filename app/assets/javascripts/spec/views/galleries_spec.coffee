
$(document).ready ->
  describe "Galleries", ->

    beforeEach ->
      a = 'a'

    afterEach ->
      # hide trashy
      elements_to_hide = [ '.galleries-set-show-style', '.trashy' ]
      _.each( elements_to_hide, (e) ->
        $( e ).css('display', 'none')
      )

    describe "change color of the background", ->
      it 'works', ->
        expect( $('.black' ).length ).toBe( 1, 'the element .black must be present.' )
        expect( $('#galleries_show').length ).toBe( 1, "#galleries_show must be present." )
        $('.black').click()
        expect( $('#galleries_show').css('background-color') ).toBe( 'rgb(3, 3, 3)' )
        