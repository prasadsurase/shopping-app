require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validations' do
    it { is_expected.to validate_numericality_of(:total).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
  end
end
