class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.belongs_to :user, foreign_key: true
      t.string :issuer
      t.string :kind
      t.date :expiration

      t.timestamps
    end
  end
end
