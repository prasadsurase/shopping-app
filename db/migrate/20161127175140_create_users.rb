class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.text :address
      t.string :encrypted_cc_number
      t.string :encrypted_cc_number_iv
      t.string :encrypted_cvv
      t.string :encrypted_cvv_iv
      t.date :cc_expiry_date

      t.timestamps
    end
  end
end
