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
  has_many :options

  def fetch
    begin
      response = HTTParty.get("https://query2.finance.yahoo.com/v7/finance/options/#{ticker}")
      JSON.parse(response.body)["optionChain"]["result"].first["options"].first["calls"]
    end
  end

  def refresh
    response = fetch
    response.each do |call|
      o = options.find_or_initialize_by(symbol: call["contractSymbol"])
      o.expires_at = Time.at(call["expiration"])
      o.strike = call["strike"].to_f * 100
      o.price = call["lastPrice"].to_f * 100
      o.volume = call["volume"]
      o.save
    end
    return nil
  end
end