class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :state
      t.float :total
      t.float :discount
      t.float :final_total

      t.timestamps
    end
  end
end
