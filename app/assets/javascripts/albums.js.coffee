$(document).on "page:change", ->
  $('#album_style').change ->
    index = $('#album_style')[0].selectedIndex
    
    $('#album_cover').attr('src', gon.sample_albums[index].avatar.url)
    $('#album_layout').attr('src', gon.sample_albums[index].album_layout.url)
    $('#album_description').text(gon.sample_albums[index].description)
    $('#album_features').html(gon.format_features_array[index])
    
    #$('#album_specifications').html(album_specifications)
    
    # Features
    
    
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
