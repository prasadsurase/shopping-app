# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  order_id    :integer
#  quantity    :integer          default(1)
#  unit_price  :float
#  total_price :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'associations' do
    subject { create :order_item }

    it { is_expected.to belong_to(:item).inverse_of(:order_items) }
    it { is_expected.to belong_to(:order).inverse_of(:order_items) }
  end

  context 'validations' do
    subject { create :order_item }

    xit { is_expected.to validate_presence_of(:quantity) }
    xit { is_expected.to validate_presence_of(:unit_price) }
    xit { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0).only_integer }
    xit { is_expected.to validate_numericality_of(:unit_price).is_greater_than(0) }
    xit { is_expected.to validate_numericality_of(:total_price).is_greater_than(0) }
  end

  context 'callbacks' do
    subject { create :order_item }

    it { is_expected.to callback(:set_values).before(:validation) }
    it { is_expected.to callback(:update_order).after(:save) }
    it { is_expected.to callback(:update_order).after(:destroy) }
  end

  describe '#set_values' do
    it 'should set the unit price and the total price' do
      order_item = create :order_item
      expect(order_item.quantity).to eq 1
      order_item.send :set_values
      expect(order_item.unit_price).to eq order_item.item.price
      expect(order_item.total_price).to eq (order_item.quantity * order_item.item.price)
    end
  end

end

