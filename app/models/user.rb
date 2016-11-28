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

class User < ApplicationRecord

  has_many :orders, inverse_of: :user
  has_many :credit_cards, inverse_of: :user

  validates :email, :address, presence: true
  validates :email, uniqueness: true

  accepts_nested_attributes_for :credit_cards, reject_if: :dup_card?

  private

  # check if the card with the provided number is present in the system. If present, consider that card and update its info.
  #
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

