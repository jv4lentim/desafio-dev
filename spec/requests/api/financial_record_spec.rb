require 'rails_helper'

RSpec.describe "API FinancialRecords", type: :request do
  describe "GET /api/financial_records/:id" do
    let!(:financial_record) { create(:financial_record) }

    context "when the financial record exists" do
      it "returns the financial record with status 200" do
        get "/api/financial_records/#{financial_record.id}"

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(financial_record.id)
      end
    end

    context "when the financial record does not exist" do
      it "returns an error message with status 404" do
        get "/api/financial_records/999999"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ "error" => "Transação não encontrada" })
      end
    end
  end
end
