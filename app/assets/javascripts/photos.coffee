

$(document).on "page:change", ->
  # all the img including album photos and photo-box-photos are draggable
  $('.draggable-photo').draggable
    containment: "body"
    revert: true
    helper: 'clone'
    zIndex: 200
    start: (event, ui) ->
      # set the image size when dragging base on the screen size
      if $(window).width() > 992
        width = 264
        height =  176
      else
        width = 150
        height = 100
      # set over-flow to show drag-object on the top
     # ui.helper[0].parentNode.style.overflow = "visible"
      ui.helper.width(width).height(height)
      #ui.helper.animate({width: width,height: height})
      # set it back to auto in case there are more images
    # stop: (event, ui) ->
    #  ui.helper[0].parentNode.style.overflow = "auto"
    # mouse cursor position after resizing when dragging
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
      temp = drag.parentNode.insertBefore(document.createTextNode(''), drag)
      
      drag.style["width"] = ""
      drag.style["height"] = ""
      # append image to div if not image exist
      if childNode == 0
        this.appendChild ui.draggable[0]
        # update photo box photos number count
        $('#badge-top').html(parseInt($('#badge-top').html()) - 1)
        $('#badge-bottom').html(parseInt($('#badge-bottom').html()) - 1)
        
      # swap images
      else
        drop.parentNode.insertBefore(drag, drop)
        temp.parentNode.insertBefore(drop, temp)
        temp.parentNode.removeChild(temp)
      #update_photo_box_badge()
      

  $('.photo-box-content').droppable
    tolerance: 'pointer'
    drop: (event, ui) ->
      hoverClass: "dragHover"
      ui.draggable[0].style["width"] = ""
      ui.draggable[0].style["height"] = ""
      
      #console.log event.target
      #console.log ui.draggable[0].parentElement#.parentNode.parentElement

      # prevent self container append
      this.appendChild ui.draggable[0]
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
  