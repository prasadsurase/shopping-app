require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:active).in_array([true, false]) }
  end
end
