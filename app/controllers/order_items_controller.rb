class OrderItemsController < ApplicationController
  def index
    @order_items = current_basket.order_items.page(params[:page]).order(:created_at)
  end

  def update
    @order_item = current_basket.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
  end

  def destroy
    @order_item = current_basket.order_items.find(params[:id])
    @order_item.destroy
  end

  private

  def order_item_params
    params.fetch(:order_item).permit(:quantity)
  end
end
