FactoryGirl.define do
  factory :promo_code do
    code '20%OFF'
    discount_type 'percentage'
    value 20
    active true
    description "20% off final cost cannot be used in conjunction with other codes"
    combined false

    trait :inactive do
      active false
    end

    trait :singular do
      combined false
    end

    trait :multiple do
      combined true
    end

    trait :percentage do
      discount_type 'percentage'
    end

    trait :flat do
      discount_type 'value'
    end

  end
end
