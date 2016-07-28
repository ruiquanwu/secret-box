$(document).on "page:change", ->
  $('.draggable-photo').draggable({revert: true, zIndex: 100})
  $('.droppable-photo').droppable 
    activeClass: 'ui-state-active'
    hoverClass: 'ui-state-hover'
    drop: (event, ui) ->
      this.appendChild ui.draggable[0]
  
  $('.photo-box-btn').click ->
    $('.right-panel').slideToggle("slow")

    
  $('#update_photos').click ->
    photos = $('div[data-photo]')

    i = 0
    updates_params = []
    while i < photos.length
      album_id = photos[i].getAttribute('data-album')
      photo_id = photos[i].getAttribute('data-photo')
      memo = $('#photo_memo_'+photo_id)[0].value
      picture_id = "0"
      if photos[i].children.length > 0
        picture_id = photos[i].children[0].getAttribute('data-picture')

      a = {memo: memo, album_id: album_id, photo_id: photo_id, picture_id: picture_id}
      updates_params.push(a)
      i += 1
    
    $.ajax({
      type: "PATCH",
      url: "/albums/" + album_id + "/photos/update_photos"
      data: {updates_params: updates_params},
      success:(data) ->
        return false
      error:(data) ->
      })     
    $('#update_photos').html("Saving...")
  

