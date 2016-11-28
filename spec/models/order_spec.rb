# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  state       :string
#  total       :decimal(8, 2)    default(0.0)
#  discount    :decimal(8, 2)    default(0.0)
#  final_total :decimal(8, 2)    default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user).inverse_of(:orders) }
    it { is_expected.to have_many(:order_items).dependent(:destroy).inverse_of(:order) }
    it { is_expected.to have_many(:items).through(:order_items) }
    it { is_expected.to have_many(:order_promo_codes).dependent(:destroy).inverse_of(:order) }
    it { is_expected.to have_many(:promo_codes).through(:order_promo_codes) }
  end

  context 'validations' do
    it { is_expected.to validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:final_total).is_greater_than_or_equal_to(0) }
  end

  context 'scopes' do
    describe 'placed' do
      it 'should return only confirmed orders' do
        confirmed_order = create :order, :placed
        unconfirmed_order = create :order, :ongoing
        orders = Order.placed
        expect(orders.count).to eq 1
        expect(orders).to include confirmed_order
      end
    end
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:order_promo_codes).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:user) }
  end

  describe '#update_total_and_discount' do
    xit 'sets the total, discount and final_total for the order' do
      order = create :order, total: 0, discount: 0, final_total: 0
      expect(order.total).to eq 0.0
      expect(order.discount).to eq 0.0
      expect(order.final_total).to eq 0.0
      order_item = create(:order_item, order: order)
      order.save
      order.reload
      expect(order.total).to eq 49.99
      expect(order.discount).to eq 0.0
      expect(order.final_total).to eq 49.99
      promo_code = create :promo_code, :flat, value: 10
      order.order_promo_codes << build(:order_promo_code, order: order, promo_code: promo_code)
      order.save
      order.reload
      expect(order.total).to eq 49.99
      expect(order.discount).to eq 10.00
      expect(order.final_total).to eq 39.99
    end
  end
end
