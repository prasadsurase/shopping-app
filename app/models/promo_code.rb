class PromoCode < ApplicationRecord

  validates :code, :discount_type, presence: true
  validates :combined, inclusion: { in: [true, false] }
  validates :discount_type, inclusion: { in: ['percentage', 'value'] }
  validates :active, inclusion: { in: [true, false] }

end

