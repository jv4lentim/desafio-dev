require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  render_views

  describe "GET #index" do
    let!(:store_apu) { create(:store, name: "Apu", owner: "Alice") }
    let!(:store_krusty)  { create(:store, name: "Krusty", owner: "Bob") }

    context "when no search parameter is provided" do
      it "returns all stores" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to include(store_apu.name, store_krusty.name)
      end
    end

    context "when a search parameter is provided" do
      it "filters stores by name (case insensitive)" do
        get :index, params: { search: "apu" }
        expect(response.body).to include(store_apu.name)
        expect(response.body).not_to include(store_krusty.name)
      end

      it "filters stores by owner (case insensitive)" do
        get :index, params: { search: "krusty" }
        expect(response.body).to include(store_krusty.name)
        expect(response.body).not_to include(store_apu.name)
      end
    end
  end

  describe "GET #show" do
    let(:store) { create(:store) }
    let!(:record_credit) { create(:financial_record, store: store, transaction_type: "credit", amount: 250.0) }
    let!(:record_debit)  { create(:financial_record, store: store, transaction_type: "debit", amount: 200.0) }

    context "when the store is found" do
      context "without transaction_type filter" do
        it "assigns the store and all its financial records" do
          get :show, params: { id: store.id }
          expect(response).to have_http_status(:success)
          expect(response.body).to include(store.name, record_credit.formatted_amount, record_debit.formatted_amount)
        end
      end

      context "with transaction_type filter" do
        it "assigns only the records of the specified type" do
          get :show, params: { id: store.id, transaction_type: "credit" }
          expect(response.body).to include(record_credit.formatted_amount)
          expect(response.body).not_to include(record_debit.formatted_amount)
        end
      end
    end

    context "when the store is not found" do
      it "returns 404 status" do
        get :show, params: { id: "non_existent_id" }
        expect(response.status).to eq(404)
      end
    end
  end
end
