class BasketsController < ApplicationController
  def destroy
    @basket = current_basket
    @basket.destroy
    session.destroy
    redirect_to root_path and return
  end
end
