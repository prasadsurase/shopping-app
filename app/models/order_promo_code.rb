class OrderPromoCode < ApplicationRecord
  belongs_to :order, inverse_of: :order_promo_codes
  belongs_to :promo_code, inverse_of: :order_promo_codes

  validates :order_id, uniqueness: { scope: :promo_code_id }
  validate :can_be_used_jointly?

  after_create :update_order

  private

  def update_order
    order.update_total_and_discount
    order.save
  end

  # validate that the enter promocodes can be used jointly
  def can_be_used_jointly?
    ids = order.order_promo_codes.collect(&:promo_code_id).uniq
    singular_promo_codes = PromoCode.where(id: ids).where(combined: false)
    # cant use count since that data isnt saved yet and count would fire an query
    if order.order_promo_codes.size > 1 and singular_promo_codes.count > 0
      self.errors.add(:promo_code_id, 'Cant be used with conjuction with other codes')
    end
  end
end
