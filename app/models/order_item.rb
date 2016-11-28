# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  order_id    :integer
#  quantity    :integer          default(1)
#  unit_price  :float
#  total_price :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OrderItem < ApplicationRecord

  belongs_to :item, inverse_of: :order_items
  belongs_to :order, inverse_of: :order_items

  validates :quantity, :unit_price, :total_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, :total_price, numericality: { greater_than: 0 }

  before_validation :set_values
  after_save :update_order
  after_destroy :update_order

  private

  #set the unit price and the total price. The unit price is saved incase the item price might change in future.
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
