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
      total += parseFloat(item.innerText, 100)
  $('#net-total').text(total)
  $('#total_price').val(total)
  
  
@initialized_order_total = () ->
  if $(".orders.new").length > 0
    if $('#option-urgent')[0].checked == true
      $('#display-urgent-total').text($('#option-urgent')[0].getAttribute('data-price'))
      $('#order-urgent').show()
    if $('#express-shipment-radio')[0].checked == true
      changeShipment($('#express-shipment-radio')[0])
    if $('#standard-shipment-radio')[0].checked == true
      changeShipment($('#standard-shipment-radio')[0])
    if $('#nextday-shipment-radio')[0].checked == true
      changeShipment($('#nextday-shipment-radio')[0])    
    calculateTotal()

$(document).on "page:change", ->
  initialized_order_total()
  
  $('#express-shipment-radio').click ->
    changeShipment(this)
    calculateTotal()
  
  $('#standard-shipment-radio').click ->
    changeShipment(this)
    calculateTotal()

  $('#nextday-shipment-radio').click ->
    changeShipment(this)    
    calculateTotal()
    
  $('#option-urgent').click ->
    if this.checked == true
      $('#display-urgent-total').text(this.getAttribute('data-price'))
      $('#order-urgent').show()
      calculateTotal()
    else
      $('#display-urgent-total').text(0)
      $('#order-urgent').hide()
      calculateTotal()
    