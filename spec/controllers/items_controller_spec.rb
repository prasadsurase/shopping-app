require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should list active items" do
      item = create :item
      get :index
      expect(assigns(:items)).to include(item)
    end

    it 'should not list inactive items' do
      item = create :item, :inactive
      get :index
      expect(assigns(:items)).to_not include(item)
    end
  end

  describe 'PUT #add_to_basket' do
    before(:each) do
      @basket = subject.send :current_basket
      @basket.order_items << build(:order_item, order: @basket)
      @basket.save
      session[:order_id] = @basket.id
      expect(Order.count).to eq 1
    end

    it 'should add item to basket if not present' do
      expect(@basket.items.count).to eq 1
      new_item = create :item
      put :add_to_basket, id: new_item.id
      expect(response).to redirect_to items_path
      @basket.reload
      expect(@basket.items.count).to eq 2
    end

    it 'should not add item to basket if already present' do
      expect(@basket.items.count).to eq 1
      item = @basket.items.first
      put :add_to_basket, id: item.id
      expect(response).to redirect_to items_path
      @basket.reload
      expect(@basket.items.count).to eq 1
    end
  end

end
