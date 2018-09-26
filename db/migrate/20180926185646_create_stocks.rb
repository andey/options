class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.timestamps
      t.string :ticker, limit: 10, null: false, unique: true
      t.integer :price, null: false
    end
  end
end
