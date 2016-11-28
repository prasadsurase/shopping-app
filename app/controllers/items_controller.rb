class ItemsController < ApplicationController
  def index
    @basket = current_basket
    @basket_items = @basket.items
    @items = Item.active.page(params[:page])
  end

  # Add the item to the basket if already not added.
  def add_to_basket
    item = Item.find(params[:id])
    basket = current_basket
    if basket.items.include? item
      redirect_to items_path, warning: 'Item already added to the basket' and return
    else
      basket.order_items.build({item: item})
      basket.valid?
      basket.save!
      session.destroy
      session[:order_id] = basket.id
      flash[:success] = 'Item has been added to the basket'
      redirect_to items_path and return
    end
  end
end
