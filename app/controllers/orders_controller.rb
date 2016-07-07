class OrdersController < ApplicationController
  def new
    @order = Order.new
    @album = Album.find(params[:album_id])
    @sample_album = SampleAlbum.find(@album.style)
    @sample_picture = SamplePicture.find_by_size(@album.photo_size)
    @picture_total = @album.photos_inserted.count * @sample_picture.price
    
    @urgent_option = ServiceLookup.find_by_name("urgent-order-option")
    @standard_shipment = ServiceLookup.find_by_name("standard-shipment")
    @express_shipment = ServiceLookup.find_by_name("express-shipment")
    @nextday_shipment = ServiceLookup.find_by_name("nextday-shipment")
  end
  
  def create
    @album = Album.find(params[:album_id])
    @sample_album = SampleAlbum.find(@album.style)
    @order = Order.new(order_params)
    @order.album = @album
    @order.user = current_user
    
    # calculate total price
    @order.calculate_total
    
    if @order.save
      redirect_to checkout_album_order_path(@album, @order)
    else
      render :new
    end
  end

  def checkout
    #@shipping_address = 
    @album = Album.find(params[:album_id])
    @order = Order.find(params[:id])
  end
  
  def pay      
      # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to album_orders_path
  
  end
  
  private
  
  def order_params
    params.require(:order).permit(:shippment, :carrier, :tracking_number, 
      :total_price, :status, :options =>[])
  end
end
