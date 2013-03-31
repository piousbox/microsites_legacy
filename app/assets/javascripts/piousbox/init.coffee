
if '#_=_' == window.location.hash
  window.location.hash = ''
  window.location.href = window.location.href.slice(0, -1)
      
$(document).ready ->

  $('.addToggle').click ->
    $(this).next().toggle()
  
  $("#layout_set").change ->
      $("#set_layout form").submit()
      
  if $(".sidebar-scroller").length > 0
    Utils.init_scroller(".sidebar-scroller")
  
  if $(".tinymce").length > 0
    tinyMCE.init
      mode: "specific_textareas",
      editor_selector: 'tinymce',
      theme: 'advanced'

  if $("#piousbox_layout").length > 0
  
    if HF.header_expanded() == true
      HF.expand_header()
    else
      HF.collapse_header()

    if HF.footer_expanded() == true
      HF.expand_footer()
    else
      HF.collapse_footer()

    $("#footer_expand a").click ->
      HF.toggle_footer()

    $("#header_expand a").click ->
      HF.toggle_header()
      
    if $("#dashboard").length > 0

      # U.views.days = new Views.Days.Index()

      $("a.scratchpad").click ->
        U.views.users.pad = new Views.Users.Pad()

      $("a.days_index").click ->
        U.views.days.index = new Views.Days.Index()
       
  if $( "#accordion" ).length > 0
    $( "#accordion" ).accordion()

  if $("#temp_layout").length > 0
    MyApp.addInitializer (options) ->
      venues_view = new Views.Venues.Index
        collection: options.venues

      MyApp.right_region.show( venues_view )

  if ('.Lapplication').length > 0
    $('ul.sf-menu').superfish()

  if $('#carousel').length > 0
    $('#carousel').infiniteCarousel({})


