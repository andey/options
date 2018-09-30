# == Schema Information
#
# Table name: stocks
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ticker       :string(10)       not null
#  price        :integer
#  volume       :integer
#  earnings_at  :datetime
#  name         :string
#  expiry_dates :string           default(["\"0\""]), is an Array
#

class AddIndexesToStock < ActiveRecord::Migration[5.2]
  def change
    add_index :stocks, :updated_at
    add_index :stocks, :ticker
    add_index :stocks, :price
    add_index :stocks, :volume
    add_index :stocks, :earnings_at
    add_index :stocks, :name
  end
end
