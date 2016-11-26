class AddValueToPromoCode < ActiveRecord::Migration[5.0]
  def change
    add_column :promo_codes, :value, :integer
  end
end
