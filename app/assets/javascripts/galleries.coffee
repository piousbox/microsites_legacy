$(document).ready ->
  if $(".shades-of-gray").length > 0
    $(".black").click ->
      $("#galleries_show").css('background', '#030303')
    $(".dark-gray").click ->
      $("#galleries_show").css('background', '#3f3f3f')
    $(".medium-gray").click ->
      $("#galleries_show").css('background', '#696969')
    $(".light-gray").click ->
      $("#galleries_show").css('background', '#cecece')
    $(".white").click ->
      $("#galleries_show").css('background', 'white')
