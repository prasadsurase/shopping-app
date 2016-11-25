class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_basket

  private

  def current_basket
    session[:order_id] ? Order.find(session[:order_id]) : Order.new
  end
end
