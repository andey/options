class ScaleOptionYield < ActiveRecord::Migration[5.2]
  def change
    change_column :options, :yield, :decimal, precision: 6, scale: 4
  end
end
