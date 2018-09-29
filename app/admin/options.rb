# == Schema Information
#
# Table name: options
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stock_id   :integer          not null
#  expires_at :date             not null
#  strike     :integer          not null
#  price      :integer          not null
#  volume     :integer          not null
#  yield      :float
#

ActiveAdmin.register Option do
  filter :stock_ticker_eq, label: 'Ticker'
  filter :expires_at
  filter :strike

  index pagination_total: false do
    column :stock
    column :updated_at do |o| time_ago_in_words o.updated_at end
    column :expires_at do |o| o.expires_at.to_date end
    column :strike
    column :price
    column :volume
    column :yield
  end
end
