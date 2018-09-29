class ScaleOptionYield < ActiveRecord::Migration[5.2]
  def up
    change_column :options, :yield, :decimal, precision: 8, scale: 4
  end

  def down

  end
end
