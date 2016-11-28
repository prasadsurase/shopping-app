require 'rails_helper'

RSpec.describe OrderPromoCode, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:order).inverse_of(:order_promo_codes) }
    it { is_expected.to belong_to(:promo_code).inverse_of(:order_promo_codes) }
  end

  context 'validations' do
    subject { create :order_promo_code }

    it { is_expected.to validate_uniqueness_of(:order_id).scoped_to(:promo_code_id) }
  end

  context 'callbacks' do
    it { is_expected.to callback(:update_order).after(:create) }
  end

  describe '#can_be_used_jointly?' do
    it 'validates if specified promocodes cannot be used in conjuction' do
      code_1 = create :promo_code, :flat, value: 5, active: true, combined: false
      code_2 = create :promo_code, :percentage, value: 10, active: true, combined: true

      order = create :order
      opc_1 = build :order_promo_code, promo_code: code_1
      opc_2 = build :order_promo_code, promo_code: code_2
      order.order_promo_codes << opc_1
      order.order_promo_codes << opc_2
      expect(opc_1).to_not be_valid
      expect(opc_2).to_not be_valid
      expect(opc_1.errors.messages[:promo_code_id]).to eq ['Cant be used with conjuction with other codes']
      expect(opc_2.errors.messages[:promo_code_id]).to eq ['Cant be used with conjuction with other codes']
    end

    it 'validates if specified promocodes cannot be used in conjuction' do
      code_1 = create :promo_code, :flat, value: 5, active: true, combined: true
      code_2 = create :promo_code, :percentage, value: 10, active: true, combined: true

      order = create :order
      opc_1 = build :order_promo_code, promo_code: code_1
      opc_2 = build :order_promo_code, promo_code: code_2
      order.order_promo_codes << opc_1
      order.order_promo_codes << opc_2
      expect(opc_1).to be_valid
      expect(opc_2).to be_valid
    end
  end

end
