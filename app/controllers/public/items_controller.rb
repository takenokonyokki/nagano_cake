class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @genres =  Genre.all
  end

  def show
    unless customer_signed_in?
      redirect_to new_customer_session_path
    end
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

end
