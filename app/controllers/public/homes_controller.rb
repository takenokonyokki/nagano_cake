class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.all
    @items_latest3 = @items.first(3)
  end

  def about
  end
end
