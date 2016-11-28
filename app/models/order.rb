# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  state       :string
#  total       :decimal(8, 2)    default(0.0)
#  discount    :decimal(8, 2)    default(0.0)
#  final_total :decimal(8, 2)    default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Order < ApplicationRecord

  belongs_to :user, optional: true, inverse_of: :orders
  has_many :order_items, dependent: :destroy, inverse_of: :order
  has_many :items, through: :order_items
  has_many :order_promo_codes, dependent: :destroy, inverse_of: :order
  has_many :promo_codes, through: :order_promo_codes

  validates :total, :discount, :final_total, numericality: { greater_than_or_equal_to: 0 }
  validates_associated :order_promo_codes

  scope :placed, ->{ where(state: :confirmed) }

  accepts_nested_attributes_for :order_promo_codes, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :user, reject_if: :dup_user?

  before_update :update_total_and_discount

  # if user is already present in the system then consider that user. update the user info with the new info
  def dup_user?(attrs)
    if attrs[:email].present?
      u = User.find_by(email: attrs[:email])
      if u
        u.attributes = attrs
        self.user = u
        true
      else
        false
      end
    else
      false
    end
  end

  # Calculate the total, discount and final_total based on the order items and associated promo codes.
  def update_total_and_discount
    if order_items.any?
      self.total = order_items.collect(&:total_price).sum
      if order_promo_codes.any?
        ids = order_promo_codes.collect(&:promo_code_id)
        percentage_discount = PromoCode.where(id: ids, discount_type: :percentage).sum(:value)
        #percentage_discount = promo_codes.where(discount_type: :percentage).collect(&:value).sum
        self.discount = ((percentage_discount.to_f/100) * total)
        value_discount = PromoCode.where(id: ids, discount_type: :value).sum(:value)
        #value_discount = promo_codes.where(discount_type: :value).collect(&:value).sum
        self.discount = discount + value_discount
      else
        self.discount = 0
      end
      # discount is greater than total then final_total is 0. else total - discount
      self.final_total = discount > total ? 0 : total - discount
    end
  end

end

