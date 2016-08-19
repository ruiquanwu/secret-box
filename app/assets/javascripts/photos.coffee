$(document).on "page:change", ->  
  # photos#index
  # all the img including album photos and photo-box-photos are draggable
  $('.draggable-photo').draggable
    revert: true
    helper: 'clone'
    zIndex: 200
    start: (event, ui) ->
      # resize image when dragging
      # if image from photo-box, resize to 0.8 original image size
      if this.parentNode.classList.contains("photo-box-content")
        ui.helper.width(this.width*0.8).height(this.height*0.8)
      # if image from album-photo, resize to 0.4 of original image size
      else
        ui.helper.width(this.width*0.4).height(this.height*0.4)
    cursorAt: {left:75, top:50}
  # album photo field is droppable  
  $('.droppable-photo').droppable 
    hoverClass: "dragHover"
    # when cursor point to the droppable area
    tolerance: 'pointer'
    drop: (event, ui) ->
      childNode = event.target.children.length
      drag = ui.draggable[0]
      drop = this.children[0]
      
      drag.style["width"] = ""
      drag.style["height"] = ""
      target_picture_id = drag.getAttribute("data-picture")
      album_id = this.getAttribute("data-album")
      photo_id = this.getAttribute("data-photo")

      # append image to album photo if not image exist
      if childNode == 0
          # update photo-box number, drag targer is from photo box
        if this.className != drag.parentElement.className
          $('#badge-top').html(parseInt($('#badge-top').html()) - 1)
          $('#badge-bottom').html($('#badge-top').html())
        this.appendChild drag
        # send ajax request to update database
        $.ajax({
          dataType: "Script",
          type: "PATCH",
          url: "/albums/" + album_id + "/photos/update_photos",
          data: {type: "Append", photo_id: photo_id, target_picture_id: target_picture_id}  
        })

        
      # swap images
      else
        temp = drag.parentNode.insertBefore(document.createTextNode(''), drag)
        drop.parentNode.insertBefore(drag, drop)
        temp.parentNode.insertBefore(drop, temp)
        temp.parentNode.removeChild(temp)
        $.ajax({
          dataType: "Script",
          type: "PATCH",
          url: "/albums/" + album_id + "/photos/update_photos",
          data: {type: "Swap", photo_id: photo_id, target_picture_id: target_picture_id}  
        })
      #update_photo_box_badge()
      

  $('.photo-box-content').droppable
    tolerance: 'pointer'
    drop: (event, ui) ->
      hoverClass: "dragHover"
      drag = ui.draggable[0]
      drag.style["width"] = ""
      drag.style["height"] = ""

      target_picture_id = drag.getAttribute("data-picture")
      album_id = drag.parentNode.getAttribute("data-album")
      photo_id = drag.parentNode.getAttribute("data-photo")
      
      if this.className != drag.parentElement.className
        $('#badge-top').html(parseInt($('#badge-top').html()) + 1)
        $('#badge-bottom').html($('#badge-top').html())
        # prevent self container append
        this.insertBefore drag, this.firstChild
        # remove picture from album photo
        $.ajax({
          dataType: "Script",
          type: "PATCH",
          url: "/albums/" + album_id + "/photos/update_photos",
          data: {type: "Remove", photo_id: photo_id, target_picture_id: target_picture_id}  
        })
        

    #  $('#badge-top').html(parseInt($('#badge-top').html()) + 1)
   #   $('#badge-bottom').html(parseInt($('#badge-bottom').html()) + 1)
  
  $('.photo-box-btn').click ->
    $('.right-panel').slideToggle("slow")
    $('.photo-box-btn').toggle()
    return false
  $('.photo-box-top-btn').click ->
    $('.right-panel').slideToggle("slow")
    $('.photo-box-btn').toggle()
    return false
    
  # on click event for update memo button
  $('.update-memo-btn').click (e) ->
    e.preventDefault()
    url = this.getAttribute('data-url')
    memo_id = this.getAttribute('data-memo')
    memo = $('#'+memo_id).val()
    $.ajax({
      dataType: "Script",
      type: "PATCH",
      url: url,
      data: {memo: memo}  
    })

    
    
  # on click event for rotate image button  
  $('.rotate-image-btn').click (e) ->
    e.preventDefault()
    # get the associate album photo of the rotate button
    associate_photo_id = "#album_photo_" + this.getAttribute("data-photo-id")
    album_photo = $(associate_photo_id).children()
    
    # check if album_photo contains any image
    if album_photo.length > 0
      # rotate image
      # if image container "rotate 180" class, remove it
      if album_photo[0].classList.contains("fa-rotate-180")
        album_photo.removeClass("fa-rotate-180")
      # else add the class to rotate
      else
        album_photo.addClass("fa-rotate-180")

  