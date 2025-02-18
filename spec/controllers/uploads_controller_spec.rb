require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  describe "POST #create" do
    let(:valid_file) { fixture_file_upload(Rails.root.join("spec/fixtures/cnab_sample.txt"), "text/plain") }

    context "when a valid CNAB file is uploaded" do
      it "processes the file and redirects with success message" do
        cnab_parser = instance_double(CnabParser, call: true)
        allow(CnabParser).to receive(:new).and_return(cnab_parser)

        post :create, params: { file: valid_file }

        aggregate_failures "verifying responses" do
          expect(CnabParser).to have_received(:new)
          expect(cnab_parser).to have_received(:call)
          expect(flash[:success]).to eq("Arquivo enviado com sucesso! O processamento está em andamento e os dados serão atualizados em breve.")
          expect(response).to redirect_to(new_upload_path)
        end
      end
    end

    context "when no file is uploaded" do
      it "redirects with error message" do
        post :create, params: {}

        aggregate_failures do
          expect(flash[:error]).to eq("Nenhum arquivo enviado.")
          expect(response).to redirect_to(new_upload_path)
        end
      end
    end

    context "when an invalid file is uploaded" do
      let(:invalid_file) { fixture_file_upload(Rails.root.join("spec/fixtures/placeholder.png"), "image/png") }

      it "redirects with specific error message" do
        post :create, params: { file: invalid_file }

        aggregate_failures do
          expect(flash[:error]).to eq("Formato de arquivo inválido")
          expect(response).to redirect_to(new_upload_path)
        end
      end
    end
  end
end
