$(document).on "page:change", ->
  $('#test-drag').draggable({revert: true}) 
  $('.drag').draggable({revert: true})
  
  $('#test-drop1').droppable drop:(ev, ui) ->
   # data = ev.dataTransfer.getData('text')
   # console.log(ev)
   # console.log(ui.draggable[0])
   # console.log(this)
    this.appendChild ui.draggable[0]
    
  $('#test-drop2').droppable drop:(ev, ui) ->
   # data = ev.dataTransfer.getData('text')
   # console.log(ev)
   # console.log(ui.draggable[0])
   # console.log(this)
    this.appendChild ui.draggable[0]
    