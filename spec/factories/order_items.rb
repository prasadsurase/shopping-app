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

FactoryGirl.define do
  factory :order_item do
    quantity 1
    unit_price 49.99
    total_price 49.99

    association :item, factory: :item, price: 49.99, discount: 0.0
    association :order, factory: :order
  end
end
