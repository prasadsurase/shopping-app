FactoryGirl.define do
  factory :order do
    state 'ongoing'
    total 100.00
    discount 10.00

    trait :ongoing do
      state 'ongoing'
    end

    trait :placed do
      state 'confirmed'
    end
  end
end
