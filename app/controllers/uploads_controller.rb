class UploadsController < ApplicationController
  def index
    stores = Store.includes(:financial_records)

    @total_stores = stores.size
    @total_financial_records = stores.sum { |store| store.financial_records.size }
    @last_stores = stores.order(created_at: :desc).limit(3)
    @last_financial_records = stores.flat_map(&:financial_records).sort_by(&:created_at).last(6)
  end

  def create
    uploaded_file = upload_params

    if uploaded_file&.content_type != "text/plain"
      flash[:error] = "Formato de arquivo inválido"
      return redirect_to new_upload_path
    end

    CnabParser.new(uploaded_file).call
    flash[:success] = "Arquivo enviado com sucesso! O processamento está em andamento e os dados serão atualizados em breve."

    redirect_to new_upload_path
  rescue ActionController::ParameterMissing
    flash[:error] = "Nenhum arquivo enviado."
    redirect_to new_upload_path
  end

  def new
  end

  private

  def upload_params
    params.require(:file)
  end
end
