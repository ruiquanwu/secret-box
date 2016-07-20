$(document).on "page:change", ->
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
  

root = exports ? this
root.allowDrop = (ev) ->
  ev.preventDefault()
  return

root.drag = (ev) ->
  ev.dataTransfer.setData 'text', ev.target.id
  return

root.drop = (ev) ->
  ev.preventDefault()
  data = ev.dataTransfer.getData('text')
  console.log(ev.target)
  #dataType = ev.target.getAttribute("data-type")
  #if dataType == "Photos"
  #  alert("Error: you have to remove photo before dropping a new one")
  #else if dataType == "Freephotos"
  #  ev.target.parentElement.appendChild document.getElementById(data)
 # else
  if ev.target.tagName == 'IMG'
    alert("Error, you cannot drag a picture over another picture")
  else
    ev.target.appendChild document.getElementById(data)
    ev.preventDefault()
  return

