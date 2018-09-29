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

class Stock < ApplicationRecord
  has_many :options, dependent: :destroy

  def display_name
    "#{ticker.upcase} #{price}"
  end

  def fetch
    expiry_dates.each do |date|
      begin
        puts "processing date: #{date}"
        # https://query2.finance.yahoo.com/v7/finance/options/amd?date=1487289600
        response = HTTParty.get("https://query2.finance.yahoo.com/v7/finance/options/#{ticker}?date=#{date}")
        process_response JSON.parse(response.body)["optionChain"]["result"].first
      end
    end
  end

  def process_response(response)
    update_stock(response)
    calls = response["options"].first["calls"]
    calls.each do |call|
      puts "processing call #{call["contractSymbol"]}"
      o = options.find_or_initialize_by(symbol: call["contractSymbol"])
      o.expires_at = Time.at(call["expiration"])
      o.strike = call["strike"].to_f * 100
      o.price = call["lastPrice"].to_f * 100
      o.volume = call["volume"]
      o.yield = calculate_yield(o.strike, o.price)
      o.updated_at = Time.now
      o.save
    end
    return nil
  end

  def update_stock(response)
    begin
      update(
          price: response["quote"]["regularMarketPrice"].to_f * 100,
          volume: response["quote"]["averageDailyVolume3Month"],
          # earnings_at: Time.at(response["quote"]["earningsTimestamp"]),
          name: response["quote"]["longName"],
          expiry_dates: response["expirationDates"],
          updated_at: Time.now
      )
    rescue
      update(update_at: Time.now)
    end
  end

  def calculate_yield(strike, call_price)
    if strike > price
      call_price.to_f / price.to_f
    else
      (call_price.to_f + strike.to_f - price.to_f) / price.to_f
    end
  end
end
