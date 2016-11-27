class OrderItem < ApplicationRecord

  belongs_to :item, inverse_of: :order_items
  belongs_to :order, inverse_of: :order_items

  validates :item, :order, :quantity, :unit_price, :total_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, :total_price, numericality: { greater_than: 0 }

  before_validation :set_values
  after_save :update_order
  after_destroy :update_order

  private

  def set_values
    self.unit_price = item.price
    self.total_price = quantity * item.price
  end

  def update_order
    if order.order_items.any?
      order.update_total_and_discount
      order.save
    else
      order.destroy
    end
  end

end
