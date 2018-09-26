# == Schema Information
#
# Table name: stocks
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ticker     :string(10)       not null
#  price      :integer          not null
#

class Stock < ApplicationRecord
  has_many :options, dependent: :destroy

  def display_name
    "#{ticker.upcase} #{price}"
  end

  def fetch
    begin
      # https://query2.finance.yahoo.com/v7/finance/options/amd?date=1487289600
      response = HTTParty.get("https://query2.finance.yahoo.com/v7/finance/options/#{ticker}")
      JSON.parse(response.body)["optionChain"]["result"].first
    end
  end

  def refresh
    response = fetch

    quote = response["quote"]
    update(
        price: quote["regularMarketPrice"].to_f * 100
    )

    calls = response["options"].first["calls"]
    calls.each do |call|
      o = options.find_or_initialize_by(symbol: call["contractSymbol"])
      o.expires_at = Time.at(call["expiration"])
      o.strike = call["strike"].to_f * 100
      o.price = call["lastPrice"].to_f * 100
      o.volume = call["volume"]
      o.yield = calculate_yield(o.strike, o.price)
      o.save
    end
    return nil
  end

  def calculate_yield(strike, call_price)
    if strike > price
      (call_price / price) * 100.0
    else
      ((call_price + strike - price)/price) * 100
    end
  end
end