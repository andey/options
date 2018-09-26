class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.timestamps
      t.integer :stock_id, null: false
      t.string :symbol, null: false, unqiue: true
      t.datetime :expires_at, null: false
      t.integer :strike, null: false
      t.integer :price, null: false
      t.integer :volume, null: false
      t.float :yield
    end
  end
end