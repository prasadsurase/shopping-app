class ItemsController < ApplicationController
  def index
    @items = Item.active.page(params[:page])
  end

  def add_to_basket
    item = Item.find(params[:id])
    basket = current_basket
    if basket.items.include? item
      redirect_to items_path, warning: 'Item already added to the basket' and return
    else
      basket.order_items.build({item: item})
      basket.valid?
      basket.save
      session.destroy
      session[:order_id] = basket.id
      redirect_to items_path, success: 'Item has been added to the basket' and return
    end
  end
end