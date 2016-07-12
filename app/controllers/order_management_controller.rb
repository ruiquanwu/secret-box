class OrderManagementController < ApplicationController
  def index
    @orders =  Order.where(user_id: current_user.id).all.paginate(page: params[:page], per_page: 5)
  end

  def show
  end
  
  def admin_index
    @orders = Order.all.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @order = Order.friendly.find(params[:id])
  end
  
  def update
    @order = Order.friendly.find(params[:id])
    
    if @order.update_attributes(order_params)
      flash[:notice] = "Order was updated"
      redirect_to order_management_edit_path(@order)
    else
      flash.now[:error] = "Error occur in Updating order"
      render :edit
    end
    
  end
  
  def download
    require 'rubygems'
    require 'zip'
    @order = Order.friendly.find(params[:id])
    filename = @order.user.name + "_" + @order.album.name + "_" + @order.created_at.to_formatted_s(:number) + ".zip"
    temp_file = Tempfile.new(filename)
    
    begin
      Zip::OutputStream.open(temp_file) {|zos|}
      
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        @order.album.photos.each do |photo|
          zip.add("photo"+photo.photo_number.to_s+".jpg", open(photo.picture.context.url))
        end
      end
      
      zip_data = File.read(temp_file.path)
      
      send_data(zip_data, type: 'application/zip', filename: filename)
    ensure
      temp_file.close
      temp_file.unlink
    
#    data = open("https://skeletonx-lazyalbum.s3.amazonaws.com/uploads/album/avatar/4/album.jpg")
    #send_file , type: 'imgae/jpg', x_sendfile: true
#    send_data data.read, filename: "something.jpg", type: "image/jpg"
    end
  end
  
  def order_params
    params.require(:order).permit(:carrier, :track_number, :status)
  end
  
end
