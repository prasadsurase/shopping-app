# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  state       :string
#  total       :decimal(8, 2)    default(0.0)
#  discount    :decimal(8, 2)    default(0.0)
#  final_total :decimal(8, 2)    default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

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
