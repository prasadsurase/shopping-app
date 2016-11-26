class CreateOrderPromoCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :order_promo_codes do |t|
      t.references :order, foreign_key: true
      t.references :promo_code, foreign_key: true

      t.timestamps
    end
  end
end
