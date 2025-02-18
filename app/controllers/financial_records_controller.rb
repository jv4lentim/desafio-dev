class FinancialRecordsController < ApplicationController
  def index
    @financial_records = FinancialRecord.includes(:store).page(params[:page]).per(10)

    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @financial_records = @financial_records
        .joins(:store)
        .where(
          "LOWER(stores.name) LIKE :search OR LOWER(financial_records.cpf_number) LIKE :search",
          search: search_term
        )
    end
  end

  def show
    @financial_record = FinancialRecord.includes(:store).find_by(id: financial_record_params)

    if @financial_record
      render :show
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  private

  def financial_record_params
    params.require(:id)
  end
end
