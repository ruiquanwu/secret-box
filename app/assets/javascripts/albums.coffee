$(document).on "page:change", ->
  $('#album_style').change ->
    album_cover = $('#album_style :selected')[0].getAttribute('data-avatar')
    album_layout = $('#album_style :selected')[0].getAttribute('data-layout')
    $('#album_cover').attr('src', album_cover)
    $('#album_layout').attr('src', album_layout)
    $('#album_cover_descption').html(style[$('#album_style').val()-1])



style = ["<ul id='album_attrs'>
            <li id='album_attr'> Holds 4x6 photos </li>
            <li id='album_attr'> Memo area </li>
            <li id='album_attr'> Deluxe, rounded bookbound spine </li>
            <li id='album_attr'> Sewn cover with embroidery </li>
            <li id='album_attr'> These live, laugh, love 4x6 photo albums are ideal for people looking to protect their cherished memories </li>
          </ul>",
          "<ul id='album_attrs'>
            <li id='album_attr'> Holds 5x6 photos </li>
            <li id='album_attr'> Memo area </li>
            <li id='album_attr'> Deluxe, rounded bookbound spine </li>
            <li id='album_attr'> Sewn cover with embroidery </li>
            <li id='album_attr'> These live, laugh, love 4x6 photo albums are ideal for people looking to protect their cherished memories </li>
          </ul>",
          "<ul id='album_attrs'>
            <li id='album_attr'> Holds 6x6 photos </li>
            <li id='album_attr'> Memo area </li>
            <li id='album_attr'> Deluxe, rounded bookbound spine </li>
            <li id='album_attr'> Sewn cover with embroidery </li>
            <li id='album_attr'> These live, laugh, love 4x6 photo albums are ideal for people looking to protect their cherished memories </li>
          </ul>",
          "<ul id='album_attrs'>
            <li id='album_attr'> Holds 7x6 photos </li>
            <li id='album_attr'> Memo area </li>
            <li id='album_attr'> Deluxe, rounded bookbound spine </li>
            <li id='album_attr'> Sewn cover with embroidery </li>
            <li id='album_attr'> These live, laugh, love 4x6 photo albums are ideal for people looking to protect their cherished memories </li>
          </ul>"]

