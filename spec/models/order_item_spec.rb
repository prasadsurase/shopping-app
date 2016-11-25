require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:order) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:item) }
    it { is_expected.to validate_presence_of(:order) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0).only_integer }
    it { is_expected.to validate_numericality_of(:unit_price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:total_price).is_greater_than(0) }
  end
end
