class ServiceLookupsController < ApplicationController
  def new
    @service = ServiceLookup.new
    authorize @service
  end
  
  def create
    @service = ServiceLookup.new(service_params)
    authorize @service
    
    if @service.save
      flash[:notice] = "New Service was saved"
      redirect_to service_lookups_path
    else
      flash.now[:notice] = "error on saving Service"
      render :new
    end
  end

  def edit
    @service = ServiceLookup.find(params[:id])
    authorize @service
  end

  def update
    @service = ServiceLookup.find(params[:id])
    authorize @service
    
    if @service.update_attributes(service_params)
      flash[:notice] = "Service was updated"
      redirect_to service_lookups_path
    else
      flash.now[:notice] = "error on updating Service"
      render :edit
    end
  end  
  
  def index
    @services = ServiceLookup.all
    authorize @services
  end
  
  def destroy
    @service = ServiceLookup.find(params[:id])
    authorize @service
    @service.destroy
    redirect_to service_lookups_path
  end
  
  private
  
  def service_params
    params.require(:service_lookup).permit(:name, :description, :price)
  end
end
