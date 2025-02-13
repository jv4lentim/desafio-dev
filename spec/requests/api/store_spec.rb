require 'rails_helper'
require 'swagger_helper'

RSpec.describe "API Stores", type: :request do
  let!(:store) { create(:store, name: "Store 1", owner: "Owner 1") }
  let!(:store2) { create(:store, name: "Store 2", owner: "Owner 2") }
  let!(:financial_record) { create(:financial_record, store: store) }

  describe "GET /api/stores" do
    before { get "/api/stores" }

    it "returns HTTP 200 OK" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the list of stores in JSON" do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)
      expect(json_response[0]["name"]).to eq("Store 1")
      expect(json_response[1]["name"]).to eq("Store 2")
    end

    it "does not include financial_records" do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).not_to include("financial_records")
    end
  end

  describe "GET /api/stores/:id" do
    context "when the store exists" do
      before { get "/api/stores/#{store.id}" }

      it "returns HTTP 200 OK" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the store data in JSON" do
        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(store.id)
        expect(json_response["financial_records"].size).to eq(1)
      end
    end

    context "when the store does not exist" do
      before { get "/api/stores/999" }

      it "returns HTTP 404 Not Found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns an error message" do
        expect(JSON.parse(response.body)["error"]).to eq("Loja não encontrada")
      end
    end
  end
end
