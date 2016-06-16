$(document).on "page:change", ->
  $('#album_style').change ->
    album_cover = $('#album_style :selected')[0].getAttribute('data-avatar')
    album_layout = $('#album_style :selected')[0].getAttribute('data-layout')
    album_description = $('#album_style :selected')[0].getAttribute('data-description')
    album_features = $('#album_style :selected')[0].getAttribute('data-features')
    album_specifications = $('#album_style :selected')[0].getAttribute('data-specifications')
    $('#album_cover').attr('src', album_cover)
    $('#album_layout').attr('src', album_layout)
    $('#album_description').text(album_description)
    $('#album_features').html(album_features)  
    $('#album_specifications').html(album_specifications)