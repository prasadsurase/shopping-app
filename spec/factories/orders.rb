FactoryGirl.define do
  factory :order do
    state 'ongoing'
    total 100.00
    discount 10.00
  end
end
