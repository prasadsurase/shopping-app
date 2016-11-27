class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :user, foreign_key: true
      t.string :encrypted_number
      t.string :encrypted_number_iv
      t.string :encrypted_cvv
      t.string :encrypted_cvv_iv
      t.date :expiry_date

      t.timestamps
    end
  end
end
