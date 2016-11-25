class OrderItemsController < ApplicationController
  def index
    @order_items = current_basket.order_items.page(params[:page])
  end

  def update
    @basket = current_basket
    @order_item = @basket.order_items.find(params[:id])
    @order_item.update_attributes({quantity: @order_item.quantity})
  end
end
