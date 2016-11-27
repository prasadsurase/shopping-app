class Order < ApplicationRecord

  belongs_to :user, optional: true, inverse_of: :orders
  has_many :order_items, dependent: :destroy, inverse_of: :order
  has_many :items, through: :order_items
  has_many :order_promo_codes, dependent: :destroy, inverse_of: :order
  has_many :promo_codes, through: :order_promo_codes

  #validates :state, presence: true
  validates :total, :discount, :final_total, numericality: { greater_than_or_equal_to: 0 }
  validates_associated :order_promo_codes

  scope :placed, ->{ where(state: :confirmed) }

  accepts_nested_attributes_for :order_promo_codes, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :user, reject_if: :dup_user?

  before_update :update_total_and_discount

  def dup_user?(attrs)
    if attrs[:email].present?
      u = User.find_by(email: attrs[:email])
      u.attributes = attrs
      self.user = u
      true
    else
      false
    end
  end

  def update_total_and_discount
    if order_items.any?
      self.total = order_items.collect(&:total_price).sum
      if order_promo_codes.any?
        percentage_discount = promo_codes.where(discount_type: :percentage).collect(&:value).sum
        self.discount = ((percentage_discount.to_f/100) * total)
        value_discount = promo_codes.where(discount_type: :value).collect(&:value).sum
        self.discount = discount + value_discount
      else
        self.discount = 0
      end
      self.final_total = total - discount
    end
  end

end

