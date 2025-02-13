class StoresController < ApplicationController
  def show
    @store = Store.includes(:financial_records).find_by(id: store_params)

    if @store
      render :show
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end

  private

  def store_params
    params.require(:id)
  end
end
