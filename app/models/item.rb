class Item < ApplicationRecord

  has_many :order_items

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :active, inclusion: { in: [true, false] }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }

end

