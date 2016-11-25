class Order < ApplicationRecord

  validates :state, presence: true
  validates :total, numericality: { greater_than: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }

end

