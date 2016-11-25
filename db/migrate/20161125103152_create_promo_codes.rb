class CreatePromoCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :promo_codes do |t|
      t.string :code
      t.string :description
      t.string :discount_type
      t.boolean :combined, default: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
