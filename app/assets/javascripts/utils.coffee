if '#_=_' == window.location.hash
  window.location.hash = ''
  window.location.href = window.location.href.slice(0, -1)
      
$(document).ready ->
  $('.addToggle').click ->
    $(this).next().toggle()

  $('.help_toggle').mouseenter ->
    $(this).next().show()
  $('.help_toggle').mouseleave ->
    $(this).next().hide()

  $("#layout_set").change ->
      $("#set_layout form").submit()
      
  if $(".sidebar-scroller").length > 0
    Utils.init_scroller(".sidebar-scroller")
  
  if $(".tinymce").length > 0
    tinyMCE.init
      mode: "specific_textareas",
      editor_selector: 'tinymce',
      theme: 'advanced'
       
  if $( "#accordion" ).length > 0
    $( "#accordion" ).accordion()

  if $("#temp_layout").length > 0
    MyApp.addInitializer (options) ->
      venues_view = new Views.Venues.Index
        collection: options.venues

      MyApp.right_region.show( venues_view )

  if $('#carousel').length > 0
    $('#carousel').infiniteCarousel({})


