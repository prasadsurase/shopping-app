class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :item, :order, :quantity, :unit_price, :total_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, :total_price, numericality: { greater_than: 0 }

end
