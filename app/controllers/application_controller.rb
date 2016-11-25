class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_basket

  private

  def current_basket
    if session[:order_id]
      order = Order.find_by({id: session[:order_id]})
      order ? order : Order.new
    else
      Order.new
    end
  end
end
