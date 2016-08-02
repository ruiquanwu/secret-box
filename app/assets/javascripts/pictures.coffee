@formatFileSize =(bytes) ->
  if typeof(bytes) != 'number'
    return ''
  if bytes >= 1000000000
    return (bytes / 1000000000).toFixed(2) + ' GB'
  if bytes > 1000000
    return (bytes / 1000000).toFixed(2) + ' MB'
  return (bytes / 1000).toFixed(2) + ' KB'

$(document).on "page:change", ->
  # photos#new
  $('#picture_upload').fileupload
    dataType: 'script'
    # when file is chosen, the add event execute
    add: (e, data) ->
      # set the js tmpl file
      data.context = $(tmpl("template-upload", data.files[0]))
#     # append to html, and display the content
      $('#files').append(data.context)
      #files.push data.files[0]
      #console.log data.files[0]
      #console.log data.context
      
      # file reader to display preview of the images before uploading
      reader = new FileReader()
      reader.onload =() ->
        dataURL = reader.result
        data.context.find('.preview')[0].src = dataURL
      reader.readAsDataURL(data.files[0])
      #$('#start-upload').click ->
      
      data.submit()
      console.log "uploading"
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.progress-bar').css('width', progress + '%')
      
    done: (e, data) ->
      console.log "uploading completed"