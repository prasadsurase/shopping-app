FactoryGirl.define do
  factory :order_item do
    item ""
    order ""
    quantity 1
    unit_price 1.5
    total_price 1.5
  end
end
