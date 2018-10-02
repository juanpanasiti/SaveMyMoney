class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.string :name
      t.string :service
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
