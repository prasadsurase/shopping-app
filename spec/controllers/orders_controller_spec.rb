require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'lists the placed orders' do
      order = create :order, :placed
      expect(Order.count).to eq 1
      get :index
      expect(assigns(:orders)).to include(order)
    end

    it 'doest not list the ongoing orders' do
      order = create :order
      expect(Order.count).to eq 1
      get :index
      expect(assigns(:orders)).to_not include(order)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      order = create :order, :placed
      get :show, id: order.id
      expect(response).to have_http_status(:success)
    end
  end

end
