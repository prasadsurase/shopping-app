require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  before(:each) do
    @basket = subject.send :current_basket
    @basket.order_items << build(:order_item, order: @basket)
    @basket.save
    session[:order_id] = @basket.id
    expect(Order.count).to eq 1
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'should list then order items' do
      get :index
      expect(assigns(:order_items)).to include(@basket.order_items.first)
    end
  end

  describe 'PATCH #update' do
    it 'should update the order item' do
      expect(@basket.order_items.count).to eq 1
      xhr :patch, :update, order_item: { quantity: 3 }, id: @basket.order_items.first.id
      expect(response).to have_http_status(:success)
      @basket.reload
      expect(@basket.order_items.count).to eq 1
      expect(@basket.order_items.first.quantity).to eq 3
    end
  end

  describe 'DELETE #destroy' do
    it 'should remote the item form the order list' do
      expect(@basket.order_items.count).to eq 1
      xhr :delete, :destroy, id: @basket.order_items.first.id
      expect(response).to have_http_status(:success)
      expect(@basket.order_items.count).to eq 0
    end
  end

end

