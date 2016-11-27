class OrdersController < ApplicationController
  def index
    @orders = Order.placed.page(params[:page])
  end

  def show
    @order = Order.find params[:id]
  end
end
