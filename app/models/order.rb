class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :state, presence: true
  validates :total, numericality: { greater_than: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }

  #accepts_nested_attributes_for :order_items

  before_validation :set_values

  private

  def set_values
    self.state = 'ongoing'
    self.total = order_items.collect(&:total_price).sum
    self.discount = 0
  end

end

