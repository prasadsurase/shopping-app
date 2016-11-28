require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:orders).inverse_of(:user) }
    it { is_expected.to have_many(:credit_cards).inverse_of(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:credit_cards) }
  end
end
