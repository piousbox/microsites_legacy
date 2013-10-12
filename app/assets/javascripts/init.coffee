if '#_=_' == window.location.hash
  window.location.hash = ''
  window.location.href = window.location.href.slice(0, -1)
      
$(document).ready ->
  $('.addToggle').click ->
    $(this).next().toggle()

  $("#layout_set").change ->
      $("#set_layout form").submit()
        
  if $(".tinymce").length > 0
    tinyMCE.init
      mode: "specific_textareas",
      editor_selector: 'tinymce',
      theme: 'advanced'
       
  if $( "#accordion" ).length > 0
    $( "#accordion" ).accordion()

  if $('#carousel').length > 0
    $('#carousel').infiniteCarousel({})


