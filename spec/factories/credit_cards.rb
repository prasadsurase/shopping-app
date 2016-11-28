# == Schema Information
#
# Table name: credit_cards
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  encrypted_number    :string
#  encrypted_number_iv :string
#  encrypted_cvv       :string
#  encrypted_cvv_iv    :string
#  expiry_date         :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :credit_card do
    user nil
    encrypted_number "MyString"
    encrpted_cvv "MyString"
    expiry_date "2016-11-28"
  end
end
