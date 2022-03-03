class Public::AddressesController < ApplicationController
  def index
    @addresses = Addresse.all
    @addresse = Addresse.new
  end

  def edit
    @addresse = Addresse.find(params[:id])
  end

  def create
    @addresse = Addresse.new(addresse_params)
    @addresse.customer_id = current_customer.id
    if @addresse.save
      redirect_to public_addresses_path(@addresse.id)
    else
      @addresses = Addresse.all
      render :index
    end
  end

  def update
    @addresse = Addresse.find(params[:id])
    if @addresse.update(addresse_params)
      redirect_to  public_addresses_path(@addresse.id)
    else
      render :edit
    end
  end

  def destroy
    @addresse = Addresse.find(params[:id])
    @addresse.destroy
    redirect_to public_addresses_path(@addresse.id)
  end

  private
  def addresse_params
    params.require(:addresse).permit(:name, :postal_code, :address)
  end

end
