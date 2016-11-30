require 'rails_helper'

RSpec.describe ItemsHelper, type: :helper do
  describe "#item_image" do
    it "returns item image name" do
      expect(helper.item_image('Smart Hub')).to eq 'smart-hub.jpg'
      expect(helper.item_image('SmartHub')).to eq 'smarthub.jpg'
      expect(helper.item_image('Smart  Hub')).to eq 'smart--hub.jpg'
    end
  end
end
