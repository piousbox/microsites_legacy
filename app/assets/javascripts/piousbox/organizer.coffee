
$(document).ready ->

  if $(".Lorganizer").length > 0

    $('.scratchpad-link').click ->
      $('.scratchpad-content').toggle()

    $('.extended-forms-link').click ->
      $('.extended-forms-content').toggle()
