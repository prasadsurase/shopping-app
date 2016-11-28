# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :decimal(8, 2)    default(0.0)
#  active     :boolean          default(TRUE)
#  discount   :decimal(8, 2)    default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
