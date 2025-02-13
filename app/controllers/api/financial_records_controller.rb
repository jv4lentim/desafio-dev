class Api::FinancialRecordsController < ApplicationController
  def show
    @financial_record = FinancialRecord.find_by(id: params[:id])

    if @financial_record
      render json: @financial_record.as_json
    else
      render json: { error: "Transação não encontrada" }, status: :not_found
    end
  end
end
