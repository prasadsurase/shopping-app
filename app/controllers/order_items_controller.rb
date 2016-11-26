class OrderItemsController < ApplicationController
  before_action :load_basket

  def index
    @order_items = @basket.order_items.page(params[:page]).order(:created_at)
  end

  def update
    @order_item = @basket.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
  end

  def destroy
    @order_item = @basket.order_items.find(params[:id])
    @order_item.destroy
  end

  private

  def load_basket
    @basket = current_basket
  end

  def order_item_params
    params.fetch(:order_item).permit(:quantity)
  end
end
