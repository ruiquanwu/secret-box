$(document).on "page:change", ->
  $('.selectpicker').selectpicker()
  $('#album_style').change ->
    index = $('#album_style')[0].selectedIndex
    
    $('#album_cover').attr('src', gon.sample_albums[index].avatar.url)
    $('#album_layout').attr('src', gon.sample_albums[index].album_layout.url)
    $('#album_description').text(gon.sample_albums[index].description)
    $('#album_features').html(gon.format_features_array[index])
    
    
    # Specifications
    $('#album-orientation').text(gon.sample_albums[index].orientation)
    $('#album-color').text(gon.sample_albums[index].color)
    $('#album-max_page').text(gon.sample_albums[index].max_page)
    $('#album-photo_per_page').text(gon.sample_albums[index].photo_per_page)
    $('#album-photo_size').text(gon.sample_albums[index].photo_size)
    $('#album-memo').text(gon.sample_albums[index].has_memo)
    $('#album-number_in_stock').text(gon.sample_albums[index].number_in_stock)
    $('#album-price').text(gon.sample_albums[index].price)
  #console.log gon.sample_albums
    
  $('#album-info-section').hide()
  $('#album-btn-section').hide()
  $('#create-album-next').click ->
    $('#album-info-section').show()
    $('#album-btn-section').show()
    $('#album-search-section').hide()
    $('#album-style-section').hide()
  $('#create-album-previous').click ->
    $('#album-btn-section').hide()
    $('#album-info-section').hide()
    $('#album-search-section').show()
    $('#album-style-section').show()      
    
    
  # front-cover-page relative
  if $('#front-cover-picture-div').length > 0
    width = $('#album-front-cover-background').width()
    height = $('#album-front-cover-background').height()
    
    front_cover_width =  parseFloat($('#front-cover-picture-div')[0].getAttribute("data-front-cover-width"))
    front_cover_height =  parseFloat($('#front-cover-picture-div')[0].getAttribute("data-front-cover-height"))
    console.log front_cover_width
    console.log front_cover_height
    
    $('#front-cover-picture-div').width(width * front_cover_width)
    $('#front-cover-picture-div').height(height * front_cover_height)
   # console.log width
   # console.log height
   # $('#front-cover-picture-div')[0].style.left = (-width*0.64).toString() + "px"
   # $('#front-cover-picture-div')[0].style.top = (height*0.25).toString() + "px"
    $('#front-cover-picture-div').draggable()
    $('#front-cover-picture-div').droppable
      drop: (event, ui) ->
        drag = ui.draggable[0]
        src = drag.getAttribute("src")
        url = this.getAttribute("update_url")
        this.style.background = 'url(' + src + ')'
        this.style["background-size"] = "contain"
        this.style["background-repeat"] = "no-repeat"
        this.style["background-position"] = "center"
        this.style["background-size"] = "100%"
        $.ajax({
          dataType: "script",
          type: "PATCH",
          url: url,
          data: {front_cover: src}
        }) 
  if $('#view-only-btn').length > 0
    if $(window).width() > 992
      $('#view-only-btn').show()
    else
      $('#view-only-btn').hide()