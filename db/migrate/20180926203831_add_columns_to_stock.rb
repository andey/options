class AddColumnsToStock < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :volume, :integer
    add_column :stocks, :earnings_at, :datetime
    add_column :stocks, :name, :string
    add_column :stocks, :expiry_dates, :string, array: true, default: [0]
  end
end
