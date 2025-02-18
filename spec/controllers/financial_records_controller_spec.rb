require 'rails_helper'

RSpec.describe FinancialRecordsController, type: :controller do
  render_views

  describe "GET #index" do
    let!(:store_apu) { create(:store, name: "Apu Store") }
    let!(:store_frodo)  { create(:store, name: "Frodo Store") }
    let!(:record1) { create(:financial_record, store: store_apu, cpf_number: "12345678900", amount: 200.0) }
    let!(:record2) { create(:financial_record, store: store_frodo, cpf_number: "98765432100", amount: 300.0) }
    let!(:record3) { create(:financial_record, store: store_apu, cpf_number: "11122233344", amount: 400.0) }

    context "when no search parameter is provided" do
      it "returns HTTP success and renders the index page" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Transações")
      end
    end

    context "when a search parameter is provided" do
      it "filters financial records by store name" do
        get :index, params: { search: "apu" }
        expect(response.body).to include(record1.formatted_amount)
        expect(response.body).to include(record3.formatted_amount)
        expect(response.body).not_to include(record2.formatted_amount)
      end

      it "filters financial records by cpf_number" do
        get :index, params: { search: "9876" }
        expect(response.body).to include(record2.formatted_amount)
        expect(response.body).not_to include(record1.formatted_amount)
        expect(response.body).not_to include(record3.formatted_amount)
      end
    end
  end

  describe "GET #show" do
    let!(:store) { create(:store) }
    let!(:financial_record) { create(:financial_record, store: store) }

    context "when the financial record exists" do
      it "returns HTTP success and displays the financial record" do
        get :show, params: { id: financial_record.id }
        expect(response).to have_http_status(:success)
        expect(response.body).to include(financial_record.formatted_amount)
      end
    end

    context "when the financial record does not exist" do
      it "returns 404 status" do
        get :show, params: { id: "non_existent_id" }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("The page you were looking for doesn’t exist.")
      end
    end
  end
end
