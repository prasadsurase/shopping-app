require 'rails_helper'

RSpec.describe BasketsController, type: :controller do
  before(:each) do
    @basket = subject.send :current_basket
    @basket.order_items << build(:order_item, order: @basket)
    @basket.save
    session[:order_id] = @basket.id
    expect(@basket.persisted?).to be_truthy
    expect(Order.count).to eq 1
  end

  describe 'DELETE #destroy' do
    it 'deletes the basket' do
      expect(@basket.persisted?).to be_truthy
      expect(session[:order_id]).to eq @basket.id
      delete :destroy, id: @basket.id
      expect(response).to redirect_to root_path
      expect(session[:order_id]).to be_nil
      expect(Order.count).to eq 0
    end
  end

  describe 'GET #checkout' do
    before(:each) do
      @active_code = create :promo_code
      @inactive_code = create :promo_code, :inactive
    end

    it 'renders the checkout page' do
      get :checkout
      expect(response).to have_http_status(:success)
    end

    it 'lists the active promocodes' do
      get :checkout
      expect(response).to have_http_status(:success)
      expect(assigns(:promo_codes)).to include(@active_code)
    end

    it "lists the order's promocodes" do
      order_promo_code = build(:order_promo_code, promo_code: @active_code)
      @basket.order_promo_codes << order_promo_code
      @basket.save
      get :checkout
      expect(response).to have_http_status(:success)
      expect(assigns(:order_promo_codes).count).to eq 1
    end
  end

  describe 'GET #payment' do
    it 'should render the payment page' do
      get :payment
      expect(response).to have_http_status(:success)
    end

    it 'should build a user object' do
      get :payment
      expect(assigns(:user).new_record?).to be_truthy
    end

    it 'should build a credit card object' do
      get :payment
      expect(assigns(:credit_card).new_record?).to be_truthy
    end
  end

  describe 'PUT #process_payment' do
    context 'valid details are provided' do
      context 'user is not already present' do
        it 'should confirm the order and create a new user' do
          expect(@basket.total).to eq @basket.items.first.price
          expect(@basket.discount).to eq 0.00
          expect(@basket.final_total).to eq 49.99
          expect(User.count).to eq 0
          expect(CreditCard.count).to eq 0
          put :process_payment, order: {id: @basket.id, user_attributes: {email: "prasad@prasad.com", address: "Pune",
            credit_cards_attributes: {"0"=>{number: "123412341234", cvv: "123", "expiry_date(1i)"=>"2016", "expiry_date(2i)"=>"11",
              "expiry_date(3i)"=>"28"}}}}
              @basket.reload
          expect(@basket.state).to eq 'confirmed'
          expect(User.count).to eq 1
          expect(@basket.user).to eq User.last
          expect(CreditCard.count).to eq 1
          expect(User.last.credit_cards.count).to eq 1
        end
      end

      context 'user is already present' do
        it 'should confirm the order and assign to the old user' do
          expect(@basket.total).to eq @basket.items.first.price
          expect(@basket.discount).to eq 0.00
          expect(@basket.final_total).to eq 49.99
          expect(User.count).to eq 0
          expect(CreditCard.count).to eq 0
          put :process_payment, order: {id: @basket.id, user_attributes: {email: "prasad@prasad.com", address: "Pune",
            credit_cards_attributes: {"0"=>{number: "123412341234", cvv: "123", "expiry_date(1i)"=>"2016", "expiry_date(2i)"=>"11",
              "expiry_date(3i)"=>"28"}}}}
              @basket.reload
          expect(@basket.state).to eq 'confirmed'
          expect(User.count).to eq 1
          expect(@basket.user).to eq User.last
          expect(CreditCard.count).to eq 1
          expect(User.last.credit_cards.count).to eq 1


          @basket = subject.send :current_basket
          @basket.order_items << build(:order_item, order: @basket)
          @basket.save
          expect(Order.count).to eq 2
          session[:order_id] = @basket.id
          put :process_payment, order: {id: @basket.id, user_attributes: {email: "prasad@prasad.com", address: "Pune",
            credit_cards_attributes: {"0"=>{number: "123412341234", cvv: "123", "expiry_date(1i)"=>"2016", "expiry_date(2i)"=>"11",
              "expiry_date(3i)"=>"28"}}}}
              @basket.reload
          expect(@basket.state).to eq 'confirmed'
          expect(User.count).to eq 1
          expect(@basket.user).to eq User.last
          expect(@basket.user.orders.count).to eq 2
          expect(CreditCard.count).to eq 1
        end
      end
    end

    context 'invalid details are provided' do
      it 'should not confirm the order' do
        expect(@basket.total).to eq @basket.items.first.price
        expect(@basket.discount).to eq 0.00
        expect(@basket.final_total).to eq 49.99
        expect(User.count).to eq 0
        expect(CreditCard.count).to eq 0
        put :process_payment, order: {id: @basket.id, user_attributes: {email: "@prasad.com", address: "Pune",
          credit_cards_attributes: {"0"=>{number: "123412", cvv: "123", "expiry_date(1i)"=>"2016", "expiry_date(2i)"=>"11",
            "expiry_date(3i)"=>"28"}}}}
        @basket.reload
        expect(@basket.state).to_not eq 'confirmed'
        expect(User.count).to eq 0
        expect(CreditCard.count).to eq 0
      end
    end
  end

  describe 'GET #check_discount' do
    it 'should apply the specified promocodes if they can be used in conjuction' do
      code_1 = create :promo_code, :flat, value: 5, active: true, combined: true
      code_2 = create :promo_code, :percentage, value: 10, active: true, combined: true
      expect(@basket.items.count).to eq 1
      expect(@basket.final_total).to eq @basket.items.first.price
      expect(@basket.order_promo_codes.count).to eq 0
      put :check_discount, order: {total: @basket.total, discount: @basket.discount,
        order_promo_codes_attributes: {"0"=>{promo_code_id: code_1.id, "_destroy"=>"false", id: @basket.id}, "1"=>{promo_code_id: code_2.id,
          "_destroy" => "false", id: @basket.id}}}
      @basket.reload
      expect(@basket.order_promo_codes.count).to eq 2
      expect(@basket.total).to eq @basket.items.first.price
      expect(@basket.discount).to eq 10.00
      expect(@basket.final_total).to eq 39.99
    end

    it 'should not apply the specified promocodes if they cannot be used in conjuction' do
      code_1 = create :promo_code, :flat, value: 5, active: true, combined: false
      code_2 = create :promo_code, :percentage, value: 10, active: true, combined: true
      expect(@basket.items.count).to eq 1
      expect(@basket.final_total).to eq @basket.items.first.price
      expect(@basket.order_promo_codes.count).to eq 0
      put :check_discount, order: {total: @basket.total, discount: @basket.discount,
        order_promo_codes_attributes: {"0"=>{promo_code_id: code_1.id, "_destroy"=>"false", id: @basket.id}, "1"=>{promo_code_id: code_2.id,
          "_destroy" => "false", id: @basket.id}}}
      @basket.reload
      expect(@basket.order_promo_codes.count).to eq 0
      expect(@basket.total).to eq @basket.items.first.price
      expect(@basket.discount).to eq 0.00
      expect(@basket.final_total).to eq @basket.items.first.price
    end
  end
end
