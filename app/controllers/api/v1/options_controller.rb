class Api::V1::OptionsController < ActionController::Base
  helper_method :sort_column, :sort_direction, :page

  def index
    @options = Stock.find_by(ticker: params[:search][:value].to_s.downcase).try(:options) || Option
  end

  private

  def sort_column
    %w(symbol updated_at stock_id expires_at strike price volume yield)[params[:order]["0"][:column].to_i]
  end

  def sort_direction
    params[:order]["0"][:dir]
  end

  def page
    params[:start].to_i/params[:length].to_i + 1
  end
end