$(document).on "page:change", ->
  $('.photo-box-btn').click ->
    $('.right-panel').slideToggle("slow")

  freephotos_length_before = $(".photo-box-content").children().length

  $('#ajax_test').click ->
    photos = $('div[data-existing-photo]')

    i = 0
    while i < photos.length
      photo_id = (photos[i].getAttribute("data-existing-photo"))
      album_id = (photos[i].getAttribute("data-album-id"))
      photo_number = (photos[i].getAttribute("data-photo-number"))

      replace_photo = photos[i].children

      if replace_photo.length
        replace_photo_id = replace_photo[0].getAttribute("data-replace-photo-id")
        type = replace_photo[0].getAttribute("data-type")
        $.ajax({
          type: "PATCH",
          url: "/albums/" + album_id + "/photos/" + photo_id
          data: { type: type, replace_photo_id: replace_photo_id, photo_number: photo_number},
          success:(data) ->
            return false
          error:(data) ->
        })
      else
        if freephotos_length_before < $(".photo-box-content").children().length
          $.ajax({
            type: "PATCH",
            url: "/albums/" + album_id + "/photos/" + photo_id
            data: { type: "remove", replace_photo_id: 0, photo_number: photo_number},
            success:(data) ->
              return false
            error:(data) ->
          })
      i += 1
      $('#ajax_test').html("Saving...")

  $('button[data-edit-memo]').click ->
    this.disabled = true
    memo = this.parentElement
    memo_body = memo.children[1].value.replace(/\n/g, "")
    album_id = memo.getAttribute("data-album-id")
    photo_id = memo.getAttribute("data-photo-id")
    $.ajax({
      type: "PATCH",
      url: "/albums/" + album_id + "/photos/" + photo_id + "/update_memo"
      data: { memo_body: memo_body, album_id: album_id, photo_id: photo_id},
      success:(data) ->
        return false
      error:(data) ->
    })


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
  dataType = ev.target.getAttribute("data-type")
  if dataType == "Photos"
    alert("Error: you have to remove photo before dropping a new one")
  else if dataType == "Freephotos"
    ev.target.parentElement.appendChild document.getElementById(data)
  else
    ev.target.appendChild document.getElementById(data)
  ev.preventDefault()
  return

