class BasketsController < ApplicationController
  before_action :load_basket

  def destroy
    @basket.destroy
    session.destroy
    redirect_to root_path and return
  end

  def checkout
    @promo_codes = PromoCode.active
  end

  def check_discount
    @basket.order_promo_codes.destroy_all
    if @basket.update(order_promo_codes_params)
      redirect_to checkout_basket_path and return
    else
      @promo_codes = PromoCode.active
      render :checkout
    end
  end

  private

  def load_basket
    @basket = current_basket
  end

  def order_promo_codes_params
    params.fetch(:order).permit(order_promo_codes_attributes: [:promo_code_id, :_destroy])
  end
end
