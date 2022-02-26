class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:id])
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end

end
