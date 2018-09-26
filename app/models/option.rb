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

class Option < ApplicationRecord
  belongs_to :stock
end
