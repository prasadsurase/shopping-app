require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_basket' do
    it 'creates a new basket if none is associated' do
      basket = subject.send :current_basket
      expect(basket.new_record?).to be_truthy
      expect(session[:order_id]).to be_nil
    end

    it 'creates a new basket if associated basket is not found' do
      order = create :order
      session[:order_id] = order.id
      order.destroy

      expect(session[:order_id]).to_not be_nil
      basket = subject.send :current_basket
      expect(basket.new_record?).to be_truthy
    end

    it 'loads the current basket if present' do
      order = create :order
      session[:order_id] = order.id

      basket = subject.send :current_basket
      expect(basket.persisted?).to be_truthy
      expect(session[:order_id]).to_not be_nil
      expect(basket).to eq order
    end
  end
end
