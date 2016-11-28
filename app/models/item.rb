# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :decimal(8, 2)    default(0.0)
#  active     :boolean          default(TRUE)
#  discount   :decimal(8, 2)    default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ApplicationRecord

  has_many :order_items

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :active, inclusion: { in: [true, false] }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }

end

