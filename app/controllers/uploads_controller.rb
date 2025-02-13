class UploadsController < ApplicationController
  def index
    @stores = Store.includes(:financial_records)
  end

  def create
    uploaded_file = upload_params

    if uploaded_file&.content_type != "text/plain"
      flash[:error] = "Formato de arquivo inválido"
      return redirect_to uploads_path
    end

    CnabParser.new(uploaded_file).call
    flash[:success] = "Arquivo enviado com sucesso! O processamento está em andamento e os dados serão atualizados em breve. Recarregue a página para ver as atualizações."

    redirect_to uploads_path
  rescue ActionController::ParameterMissing
    flash[:error] = "Nenhum arquivo enviado."
    redirect_to uploads_path
  end

  private

  def upload_params
    params.require(:file)
  end
end
