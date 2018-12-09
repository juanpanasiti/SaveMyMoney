class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :payable, polymorphic: true
      t.integer :fee
      t.decimal :amount
      t.string :status
      t.date :expiration
      
      t.timestamps
    end
    add_index :payments, [:payable_id, :payable_type]
  end
end
