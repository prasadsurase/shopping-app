class PromoCode < ApplicationRecord

  has_many :order_promo_codes, dependent: :destroy, inverse_of: :promo_code

  validates :code, :discount_type, :value, presence: true
  validates :combined, inclusion: { in: [true, false] }
  validates :active, inclusion: { in: [true, false] }
  validates :discount_type, inclusion: { in: ['percentage', 'value'] }
  validates :value, numericality: { only_integer: true, greater_than: 0 }

  scope :active, ->{ where(active: true) }

end

