class CreateMonthlies < ActiveRecord::Migration[5.2]
  def change
    create_table :monthlies do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.decimal :amount
      t.references :credit_card, foreign_key: true

      t.timestamps
    end
  end
end
