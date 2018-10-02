class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :payable, polymorphic: true, index: true
      #t.references :imageable, polymorphic: true, index: true
      t.string :fee
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
