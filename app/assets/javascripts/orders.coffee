@add_option_detail = (element) ->
  option_id = element.id
  option_name = element.value
  table = $('#display-order-detail')[0]
  total_row = table.rows.length
  inserted_row = total_row - 2
  option_row = table.insertRow(inserted_row)
  option_row.setAttribute("id", "display_"+option_id)

  option_name_cell = option_row.insertCell()
  option_name_cell.innerText = option_name

  option_qty_cell = option_row.insertCell()
  option_qty_cell.innerText = 1
  
  option_price_cell = option_row.insertCell()
  option_price_cell.innerText = "$" + gon.options[option_name].toFixed(2)

  option_total_cell = option_row.insertCell()
  option_total_cell.innerText = "$" + gon.options[option_name].toFixed(2) 
  option_total_cell.setAttribute("class", "item-total")
  
@remove_option_detail = (element) ->
  remove_id = "#display_" + element.id
  $(remove_id).remove()

@changeShipment = (element) ->
  name = element.getAttribute('data-name')
  price = element.getAttribute('data-price')
  $('#display-shipment-name').text(name)
  $('#display-shipment-price').text(price)
  $('#display-shipment-total').text(price)
  
@calculateTotal = () ->
  item_totals = $('.item-total')
  total = 0
  for item in item_totals
    do (item) ->
      total += parseFloat(item.innerText.replace('$',''), 100)
  $('#net-total').text(total.toFixed(2))
  $('#total_price').val(total.toFixed(2))

$(document).on "page:change", ->
#$(".orders").ready -> 
  #initialized_order_total()
  for name of gon.options
    option_id = '#'+gon.option_id_prefix+name
    $(option_id).click ->
      if this.checked
        add_option_detail this
      else
        remove_option_detail this
      calculateTotal()
      
  for shipment in gon.shipments
    shipment_id = "#" + gon.shipment_id_prefix + shipment.name
    #console.log(shipment_id)
    $(shipment_id).click ->
      changeShipment(this)
      calculateTotal()
  