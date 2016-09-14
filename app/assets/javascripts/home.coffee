$(document).on "page:change", ->
  # demo drop action
  $('.droppable-photo-demo').droppable 
    activeClass: "ui-state-default"
    # when cursor point to the droppable area
    tolerance: 'pointer'
    drop: (event, ui) ->
      childNode = event.target.children.length
      drag = ui.draggable[0]
      drop = this.children[0]  
      # replace target content
      this.replaceChild(drag, drop)
      
      # disable draggable picture
      drag.classList.remove('ui-draggable')
      $('#demo-drag-picture').draggable( 'disable' )
      # format picture and show instructions
      $('#demo-try-it-yourself')[0].removeChild($('#demo-drag-images')[0])
      $('#photo-action-instructions').show()
  $('#photo-action-instructions').hide()
