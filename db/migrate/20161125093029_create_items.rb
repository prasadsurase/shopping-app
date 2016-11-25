class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.boolean :active
      t.integer :discount

      t.timestamps
    end
  end
end
