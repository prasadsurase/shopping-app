class User < ApplicationRecord

  has_many :orders, inverse_of: :user

  validates :email, :address, :cc_number, :cvv, :cc_expiry_date, presence: true
  validates :email, uniqueness: true
  validates :cc_number, numericality: { only_integer: true }
  validates :cc_number, length: { is: 12 }

  attr_encrypted_options.merge!(encode: true)
  attr_encrypted :cc_number, :cvv, key: Rails.application.secrets.encryption_key

end
