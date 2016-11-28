# == Schema Information
#
# Table name: order_promo_codes
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  promo_code_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :order_promo_code do
    order
    promo_code
  end
end
