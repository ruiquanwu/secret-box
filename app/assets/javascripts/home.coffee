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
      
      this.replaceChild(drag, drop)
