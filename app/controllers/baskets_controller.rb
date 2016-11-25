class BasketsController < ApplicationController
  def show
    @basket = current_basket
  end
end
