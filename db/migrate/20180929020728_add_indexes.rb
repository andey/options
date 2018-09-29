# == Schema Information
#
# Table name: options
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stock_id   :integer          not null
#  symbol     :string           not null
#  expires_at :datetime         not null
#  strike     :integer          not null
#  price      :integer          not null
#  volume     :integer          not null
#  yield      :float
#

class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :options, :stock_id
    add_index :options, :symbol, unique: true
    add_index :options, :expires_at
    add_index :options, :strike
    add_index :options, :volume
    add_index :options, :yield
  end
end
