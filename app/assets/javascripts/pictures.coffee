@formatFileSize =(bytes) ->
  if typeof(bytes) != 'number'
    return ''
  if bytes >= 1000000000
    return (bytes / 1000000000).toFixed(2) + ' GB'
  if bytes > 1000000
    return (bytes / 1000000).toFixed(2) + ' MB'
  return (bytes / 1000).toFixed(2) + ' KB'

$(document).on "page:change", ->
    
  $('#mass-delete-btn').click ->
    if $('input:checkbox:checked').length > 0
      $('#pictures-form').submit()
  
  # picture#new
  $('#picture_upload').fileupload
    dataType: 'script'
    # when file is chosen, the add event execute
    add: (e, data) ->
      # set the js tmpl file
      data.context = $(tmpl("template-upload", data.files[0]))
#     # append to html, and display the content
      $('#files').append(data.context)
      
      # file reader to display preview of the images before uploading
      reader = new FileReader()
      reader.onload =() ->
        dataURL = reader.result
        data.context.find('.preview')[0].src = dataURL
      reader.readAsDataURL(data.files[0])
      #$('#start-upload').click ->
      
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.progress-bar').css('width', progress + '%')
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('#progress-all-bar').css('width', progress + '%')      
      #if progress == 100
        # if file upload completed, remove table context and update pictures
        #$('#files').html("")

        
        #alert("File Upload Completed!")
        
    done: (e, data) ->
      # ajax update
      $('#files').html("")