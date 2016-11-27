class BasketsController < ApplicationController
  before_action :load_basket

  def destroy
    @basket.destroy
    session.destroy
    flash[:success] = 'Basket emptied successfully'
    redirect_to root_path and return
  end

  def checkout
    @promo_codes = PromoCode.active
    @order_promo_codes = @basket.order_promo_codes
  end

  def payment
    @user = @basket.build_user
  end

  def process_payment
    if @basket.update(basket_payment_params.merge(state: :confirmed))
      session.destroy
      flash[:success] = 'Payment successful'
      redirect_to items_path and return
    end
    @user = @basket.user
    render :payment
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

  def basket_payment_params
    params.fetch(:order).permit(:id, user_attributes: [:email, :address, :cc_number, :cvv, :cc_expiry_date])
  end
end
