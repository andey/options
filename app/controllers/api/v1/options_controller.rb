class Api::V1::OptionsController < ActionController::Base
  def index
    render json: {data: Option.interesting.order(:yield).reverse_order.page(params[:start].to_i/10).per(params[:length]), pages: 10 }
  end
end