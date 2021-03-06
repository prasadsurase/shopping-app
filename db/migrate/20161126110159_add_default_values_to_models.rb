class AddDefaultValuesToModels < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :total, :decimal, precision: 8, scale: 2
    change_column :orders, :discount, :decimal, precision: 8, scale: 2
    change_column :orders, :final_total, :decimal, precision: 8, scale: 2
    change_column :items, :discount, :decimal, precision: 8, scale: 2
    change_column :items, :price, :decimal, precision: 8, scale: 2

    change_column_default :orders, :total, 0.0
    change_column_default :orders, :discount, 0.0
    change_column_default :orders, :final_total, 0.0
    change_column_default :order_items, :quantity, 1
    change_column_default :items, :discount, 0
    change_column_default :items, :price, 0
    change_column_default :promo_codes, :value, 0
    change_column_default :promo_codes, :discount_type, 'value'
  end
end
