require 'rails_helper'

RSpec.describe Item, type: :model do

  context 'associations' do
    it { is_expected.to have_many(:order_items) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_inclusion_of(:active).in_array([true, false]) }
  end

  context 'scopes' do
    describe 'active' do
      it 'should return only active items' do
        active_item = create :item
        inactive_item = create :item, :inactive
        items = Item.active
        expect(items.count).to eq 1
        expect(items).to include active_item
      end
    end

    describe 'inactive' do
      it 'should return only inactive items' do
        active_item = create :item
        inactive_item = create :item, :inactive
        items = Item.inactive
        expect(items.count).to eq 1
        expect(items).to include inactive_item
      end
    end
  end
end
