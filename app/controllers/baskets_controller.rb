class BasketsController < ApplicationController
  def show
    @basket = current_basket
  end

  def edit
    @basket = current_basket
  end

  def destroy
    @basket = current_basket
    @basket.destroy
    session.destroy
    redirect_to root_path and return
  end
end
