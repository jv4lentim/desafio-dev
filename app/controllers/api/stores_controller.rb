class Api::StoresController < ApplicationController
  def index
    @stores = Store.all

    render json: @stores.as_json(only: [ :id, :name, :owner ])
  end

  def show
    @store = Store.includes(:financial_records).find_by(id: params[:id])

    if @store
      render json: @store.as_json(include: :financial_records)
    else
      render json: { error: "Loja não encontrada" }, status: :not_found
    end
  end
end
