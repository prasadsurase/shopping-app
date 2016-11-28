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

class CreditCard < ApplicationRecord
  belongs_to :user, inverse_of: :credit_cards

  validates :number, :cvv, :expiry_date, presence: true
  validates :number, :cvv, numericality: { only_integer: true }
  validates :number, length: { is: 12 }
  validates :cvv, length: { is: 3 }

  attr_encrypted_options.merge!(encode: true)
  # encrypt the credit card number and cvv using the encryption_key
  attr_encrypted :number, :cvv, key: Rails.application.secrets.encryption_key
end
