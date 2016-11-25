require 'rails_helper'

RSpec.describe PromoCode, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount_type) }
    it { is_expected.to validate_inclusion_of(:combined).in_array([true, false]) }
    it { is_expected.to validate_inclusion_of(:active).in_array([true, false]) }
    it { is_expected.to validate_inclusion_of(:discount_type).in_array(['percentage', 'value']) }
  end
end
