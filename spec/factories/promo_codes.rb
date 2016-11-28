# == Schema Information
#
# Table name: promo_codes
#
#  id            :integer          not null, primary key
#  code          :string
#  description   :string
#  discount_type :string           default("value")
#  combined      :boolean          default(TRUE)
#  active        :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  value         :integer          default(0)
#

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
