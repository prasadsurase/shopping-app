class User < ApplicationRecord

  has_many :orders, inverse_of: :user
  has_many :credit_cards, inverse_of: :user

  validates :email, :address, presence: true
  validates :email, uniqueness: true

  accepts_nested_attributes_for :credit_cards
end
