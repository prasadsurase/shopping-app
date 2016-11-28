# == Schema Information
#
# Table name: promo_codes
#
#  id            :integer          not null, primary key
#  code          :string
#  description   :string
#  discount_type :string           default("value")
#  combined      :boolean          default(TRUE)
#  active        :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  value         :integer          default(0)
#

require 'rails_helper'

RSpec.describe PromoCode, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:order_promo_codes).dependent(:destroy).inverse_of(:promo_code) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount_type) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_inclusion_of(:combined).in_array([true, false]) }
    it { is_expected.to validate_inclusion_of(:active).in_array([true, false]) }
    it { is_expected.to validate_inclusion_of(:discount_type).in_array(['percentage', 'value']) }
    it { is_expected.to validate_numericality_of(:value).is_greater_than(0).only_integer }
  end

  context 'scopes' do
    describe 'active' do
      it 'should return only active promo_codes' do
        active_promo_code = create :promo_code
        inactive_promo_code = create :promo_code, :inactive
        promo_codes = PromoCode.active
        expect(promo_codes.count).to eq 1
        expect(promo_codes).to include active_promo_code
      end
    end
  end
end
