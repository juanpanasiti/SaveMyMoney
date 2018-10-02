class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.references :credit_card, foreign_key: true
      t.decimal :amount
      t.integer :fees
      t.date :first_payment
      t.string :status

      t.timestamps
    end
  end
end
