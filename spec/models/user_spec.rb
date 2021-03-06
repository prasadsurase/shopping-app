# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
    it { is_expected.to validate_email_format_of(:email).with_message('invalid email format') }
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:credit_cards) }
  end
end
