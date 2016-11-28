FactoryGirl.define do
  factory :order_item do
    quantity 1
    unit_price 49.99
    total_price 49.99

    association :item, factory: :item, price: 49.99, discount: 0.0
    association :order, factory: :order
  end
end
