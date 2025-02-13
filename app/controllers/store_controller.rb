class StoreController < ApplicationController
  def show
    @store = Store.includes(:financial_records).find_by(id: store_params)

    render file: "#{Rails.root}/public/404.html", status: :not_found unless @store
  end

  private

  def store_params
    params.require(:id)
  end
end
