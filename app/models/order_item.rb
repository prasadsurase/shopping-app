class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :item, :order, :quantity, :unit_price, :total_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, :total_price, numericality: { greater_than: 0 }

  after_initialize :set_values
  before_update :set_values
  after_update :update_order
  after_destroy :update_order


  private

  def set_values
    self.quantity ||= 1
    self.unit_price = item.price
    self.total_price = self.quantity * item.price
  end

  def update_order
    if order.order_items.count > 0
      order.send :set_values
      order.save
    else
      order.destroy
    end
  end

end
