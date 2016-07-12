class OrdersController < ApplicationController
  def new
    @order = Order.new
    @album = Album.friendly.find(params[:album_id])
    @sample_album = SampleAlbum.find(@album.style)
    @sample_picture = SamplePicture.find_by_size(@album.photo_size)
    @picture_total = @album.photos_inserted.count * @sample_picture.price
    
    @urgent_option = ServiceLookup.find_by_name("urgent-order-option")
    @standard_shipment = ServiceLookup.find_by_name("standard-shipment")
    @express_shipment = ServiceLookup.find_by_name("express-shipment")
    @nextday_shipment = ServiceLookup.find_by_name("nextday-shipment")
  end
  
  def create
    @album = Album.friendly.find(params[:album_id])
    @sample_album = SampleAlbum.find(@album.style)
    @order = Order.new(order_params)
    @order.album = @album
    @order.user = current_user
    
    # calculate total price
    # @order.calculate_total
    # set order status to "submitted"
    @order.status = "submitted"
    
    if @order.save
      redirect_to checkout_album_order_path(@album, @order)
    else
      render :new
    end
  end
  
  def edit    
    @order = Order.friendly.find(params[:id])
    @album = Album.friendly.find(params[:album_id])
    @sample_album = SampleAlbum.find(@album.style)
    @sample_picture = SamplePicture.find_by_size(@album.photo_size)
    @picture_total = @album.photos_inserted.count * @sample_picture.price
    
    @urgent_option = ServiceLookup.find_by_name("urgent-order-option")
    @standard_shipment = ServiceLookup.find_by_name("standard-shipment")
    @express_shipment = ServiceLookup.find_by_name("express-shipment")
    @nextday_shipment = ServiceLookup.find_by_name("nextday-shipment")
  end
  
  def update
    @album = Album.friendly.find(params[:album_id])
    @order = Order.friendly.find(params[:id])
    
    params[:order][:options] = [] if params[:order][:options].blank?
    
    
    if @order.update_attributes(order_params)
      flash[:notice] = "Order was updated"
      redirect_to checkout_album_order_path(@album, @order)
    else
      flash.now[:error] = "Error updating order"
      render :edit
    end
  end
  
  def destroy
    @album = Album.friendly.find(params[:album_id])
    @order = Order.find(params[:id])
    @order.destroy
    
    redirect_to @album
  end

  def checkout
    #@shipping_address = 
    @album = Album.friendly.find(params[:album_id])
    @order = Order.friendly.find(params[:id])
    @sample_album = SampleAlbum.find(@album.style)
    @sample_picture = SamplePicture.find_by_size(@album.photo_size)
    @picture_total = @album.photos_inserted.count * @sample_picture.price
    
    @urgent_option = ServiceLookup.find_by_name("urgent-order-option")
    @shipment = ServiceLookup.find_by_name(@order.shippment)
  end
  
  def confirm
    @order = Order.friendly.find(params[:id])
    @amount = (@order.total_price * 100).round
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Album for user'+current_user.name,
      :currency    => 'usd'
      )
    
    @shipping_address = ShippingAddress.new(name: params[:stripeShippingName], address_line1: params[:stripeShippingAddressLine1],
      state: params[:stripeShippingAddressState], city: params[:stripeShippingAddressCity], zipcode: params[:stripeShippingAddressZip])
    @shipping_address.order = @order
    @shipping_address.save
    
    
    @order.status = "In Progress"
    @order.save
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to album_orders_path  
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:shippment, :carrier, :tracking_number, 
      :total_price, :status, :options =>[])
  end

  def shipping_address_params
    params.permit(:stripeShippingName, :stripeShippingAddressLine1, :stripeShippingAddressState, 
      :stripeShippingAddressCity, :stripeShippingAddressZip)
  end
end
