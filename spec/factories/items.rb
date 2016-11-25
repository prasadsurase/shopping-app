FactoryGirl.define do
  factory :item do
    name "MyString"
    price 1.5
    active false
    discount 1
  end

  trait :active do
    active true
  end

  trait :inactive do
    active false
  end
end
