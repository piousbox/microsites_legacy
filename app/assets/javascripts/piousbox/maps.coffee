
CanvasOps.events_show_initialize = (x, y) ->
  latlng = new google.maps.LatLng(x, y)
  myOptions =
    zoom: 14
    center: latlng
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas_2"), myOptions)
  marker = new google.maps.Marker(
    position: latlng
    map: map
  )

CanvasOps.cities_index_initialize = ->
  $.get "/cities.json", (data) ->

    myOptions =
      zoom: 3
      center: new google.maps.LatLng(39.368279, 9.785149)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById("cities_index_canvas"), myOptions)

    $.each data, (idx, val) ->
      if val["x"] isnt null and val["y"] isnt null
        myLatlng = new google.maps.LatLng(val["x"], val["y"])
        contentString = "<div class='blah blah'>" + "<h4><a href='/cities/travel-to/" + val["cityname"] + "'>" + val["name"] + "</a></h4>" + "</div>"
        infowindow = new google.maps.InfoWindow(content: contentString)
        marker = new google.maps.Marker(
          position: myLatlng
          map: map
          title: val["name"]
        )
        google.maps.event.addListener marker, "click", ->
          open_infowindow.close()  if open_infowindow
          infowindow.open map, marker
          open_infowindow = infowindow

CanvasOps.users_show_initialize = (user_id) ->
  $.get "/users/" + user_id + ".json", (data) ->
    small_options =
      zoom: 14
      center: new google.maps.LatLng(data['x'], data['y'])
      mapTypeId: google.maps.MapTypeId.ROADMAP

    small_map = new google.maps.Map(document.getElementById("user_small_map_canvas"), small_options)
    
    small_marker = new google.maps.Marker(
      position: new google.maps.LatLng data['x'], data['y']
      title: data['email']
    )
    small_marker.setMap(small_map)
    
    large_options = 
      zoom: 3
      center: new google.maps.LatLng(data['x'], data['y'])
      mapTypeId: google.maps.MapTypeId.ROADMAP
      
    large_map = new google.maps.Map(document.getElementById("user_large_map_canvas"), large_options)
    
    $.each data['cities'], (idx, val) ->
      marker = new google.maps.Marker(
         position: new google.maps.LatLng val['x'], val['y']
         title: val['name']
       )
       marker.setMap(large_map)
       
       infowindow = new google.maps.InfoWindow(
         content: '<a href="/cities/travel-to/' + val['name_seo'] + '">' + val['name'] + '</a>'
       )
       google.maps.event.addListener marker, 'click', ->
         infowindow.open large_map, marker
  
CanvasOps.homepage_all_cities = ->
  myOptions =
    center: new google.maps.LatLng(21.453069,-60.571291)
    zoom: 2
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("homepage_canvas"), myOptions)
  
  $.get "/cities/map_all.json", (data) ->
    $.each data, (idx, val) ->

       marker = new google.maps.Marker(
         position: new google.maps.LatLng val['x'], val['y']
         title: val['name']
       )
       marker.setMap(map)
       
       infowindow = new google.maps.InfoWindow(
         content: '<a href="/cities/travel-to/' + val['name_seo'] + '">' + val['name'] + '</a>'
       )
       google.maps.event.addListener marker, 'click', ->
         infowindow.open map, marker
         
CanvasOps.homepage_feature_cities = ->
  myOptions =
    center: new google.maps.LatLng(21.453069,-60.571291)
    zoom: 2
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("homepage_canvas"), myOptions)
  
  $.get "/cities/map.json", (data) ->
    $.each data, (idx, val) ->

       marker = new google.maps.Marker(
         position: new google.maps.LatLng val['x'], val['y']
         title: val['name']
       )
       marker.setMap(map)
       
       infowindow = new google.maps.InfoWindow(
         content: '<a href="/cities/travel-to/' + val['name_seo'] + '">' + val['name'] + '</a>'
       )
       google.maps.event.addListener marker, 'click', ->
         infowindow.open map, marker

CanvasOps.reports_show = ->
  canvas = $("#reports_show_canvas")
  x = canvas.attr('x')
  y = canvas.attr('y')
  name_seo = canvas.attr('name_seo')

  myOptions =
    center: new google.maps.LatLng(x, y)
    zoom: 11
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById('reports_show_canvas'), myOptions)

  $.get "/reports/" + name_seo + "/venues.json", (data) ->
    $.each data, (idx, val) ->
      
      marker = new google.maps.Marker(
        position: new google.maps.LatLng val['x'], val['y']
        title: val['name']
      )
      marker.setMap(map)

      infowindow = new google.maps.InfoWindow(
        content: '<a href="/venues/show/' + val['name_seo'] + '">' + val['name'] + '</a>'
      )
      google.maps.event.addListener marker, 'click', ->
        infowindow.open map, marker

$(document).ready ->
  
  $('.all_cities').on 'click', ->
    $('.all_cities').addClass('selected')
    $('.feature_cities').removeClass('selected')
    CanvasOps.homepage_all_cities()
    
  $('.feature_cities').on 'click', ->
    $('.all_cities').removeClass('selected')
    $('.feature_cities').addClass('selected')
    CanvasOps.homepage_feature_cities()
    
  if $("#homepage_canvas").length > 0

    feature_cities_selected = false

    if feature_cities_selected
      CanvasOps.homepage_feature_cities()
    else
      CanvasOps.homepage_all_cities()

  if $("#venues_show_canvas").length > 0
    x = $("#venues_show_canvas").attr('x')
    y = $("#venues_show_canvas").attr('y')

    latlng = new google.maps.LatLng(x, y)
    myOptions =
      zoom: 14
      center: latlng
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById("venues_show_canvas"), myOptions)
    marker = new google.maps.Marker(
      position: latlng
      map: map
    )

  if $("#reports_show_canvas").length > 0
    CanvasOps.reports_show()


