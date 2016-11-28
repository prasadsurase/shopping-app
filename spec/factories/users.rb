# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user do
    email "MyString"
    address "MyText"
    cc_number 1
  end
end
