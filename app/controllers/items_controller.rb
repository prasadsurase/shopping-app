class ItemsController < ApplicationController
  def index
    @items = Item.active.page(params[:page])
  end
end
