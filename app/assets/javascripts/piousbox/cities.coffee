
$(document).ready ->
        
  
  if $('#cities_show').length > 0 || $('#cities_profile').length > 0
  
    # Utils.scroll_to('#cities_show')
    #
    # if $("#layout_light_semantic").length > 0
    #   Utils.init_scroller( '#header_city', 'scroller-fixed' )

    city_id = $(".ids").attr('cityname')
    
    CanvasOps.cities_show_initialize(city_id)