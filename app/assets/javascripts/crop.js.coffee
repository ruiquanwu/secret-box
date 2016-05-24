$(".photos.crop").ready ->
  jQuery ->
    new CarrierWaveCropper()

  class CarrierWaveCropper
    constructor: ->
      $('#photo_picture_cropbox').Jcrop
        aspectRatio: 1
        setSelect: [0, 0, 600, 900]
        onSelect: @update
        onChange: @update

    update: (coords) =>
      $('#photo_picture_crop_x').val(coords.x)
      $('#photo_picture_crop_y').val(coords.y)
      $('#photo_picture_crop_w').val(coords.w)
      $('#photo_picture_crop_h').val(coords.h)
      @updatePreview(coords)

    updatePreview: (coords) =>
      $('#photo_picture_previewbox').css
        width: Math.round(100/coords.w * $('#photo_picture_cropbox').width()) + 'px'
        height: Math.round(100/coords.h * $('#photo_picture_cropbox').height()) + 'px'
        marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
        marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
