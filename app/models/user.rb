class User < ApplicationRecord

  has_many :orders, inverse_of: :user
  has_many :credit_cards, inverse_of: :user

  validates :email, :address, presence: true
  validates :email, uniqueness: true

  accepts_nested_attributes_for :credit_cards, reject_if: :dup_card?

  private

  def dup_card?(attrs)
    if attrs[:number].present?
      cc = credit_cards.select{|cc| cc.number == attrs[:number]}.first
      if cc
        cc.attributes = attrs
        true
      else
        false
      end
    else
      false
    end
  end
end

