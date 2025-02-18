class StoresController < ApplicationController
  def index
    @stores = Store.includes(:financial_records)

    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @stores = @stores.where(
        "LOWER(name) LIKE :search OR LOWER(owner) LIKE :search",
        search: search_term
      )
    end
  end

  def show
    @store = Store.includes(:financial_records).find_by(id: store_params)

    if @store
      @financial_records = @store.financial_records
      @financial_records = @financial_records.where(transaction_type: params[:transaction_type]) if params[:transaction_type].present?

      render :show
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  private

  def store_params
    params.require(:id)
  end
end
