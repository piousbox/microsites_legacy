
$(document).ready ->
  describe "Non-MVCd stuff", ->

    beforeEach ->
      spyOn( $.fn, 'accordion' )
      U.setup_accordion()

    describe "accordion", ->
      it 'works', ->
        expect( $('#accordion' ).length ).toBe( 1, 'the element must be there.' )
        expect( $.fn.accordion ).toHaveBeenCalled()