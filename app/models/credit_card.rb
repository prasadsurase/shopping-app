class CreditCard < ApplicationRecord
  belongs_to :user, inverse_of: :credit_cards

  validates :number, :cvv, :expiry_date, presence: true
  validates :number, :cvv, numericality: { only_integer: true }
  validates :number, length: { is: 12 }
  validates :cvv, length: { is: 3 }

  attr_encrypted_options.merge!(encode: true)
  attr_encrypted :number, :cvv, key: Rails.application.secrets.encryption_key
end