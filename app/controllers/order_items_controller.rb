class OrderItemsController < ApplicationController
  def update
    @basket = current_basket
    @order_item = @basket.order_items.find(params[:id])
    @order_item.update_attributes({quantity: @order_item.quantity})
  end
end
