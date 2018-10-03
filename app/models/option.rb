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
#  yield      :decimal(5, 4)
#

class Option < ApplicationRecord
  belongs_to :stock
  scope :interesting, -> { where('options.expires_at < ?', 3.months.from_now).where('options.volume > 10').where('updated_at > ?', 1.day.ago) }

  def calculate_yield
    if strike > stock.price
      price.to_f / stock.price.to_f * 100.0
    else
      ((price + strike - stock.price)/stock.price.to_f) * 100.0
    end
  end
end
