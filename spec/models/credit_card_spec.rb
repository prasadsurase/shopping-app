require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user).inverse_of(:credit_cards) }
  end

  context 'validations' do
    it { is_expected.to validate_numericality_of(:number).only_integer }
    it { is_expected.to validate_numericality_of(:cvv).only_integer }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_presence_of(:expiry_date) }
    it { is_expected.to validate_length_of(:number).is_equal_to(12) }
    it { is_expected.to validate_length_of(:cvv).is_equal_to(3) }
  end
end
