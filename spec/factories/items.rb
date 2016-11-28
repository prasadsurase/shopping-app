FactoryGirl.define do
  factory :item do
    name 'My Item'
    price 49.99
    active true
    discount 0

    trait :inactive do
      active false
    end
  end
end
