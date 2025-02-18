require 'rails_helper'

RSpec.describe "Stores", type: :request do
  let!(:store) { create(:store) }
  let!(:financial_record) { create(:financial_record, store: store) }

  describe "GET /store/:id" do
    context "when the store exists" do
      before do
        get store_path(store.id)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the store name in the response" do
        expect(response.body).to include(store.name)
      end

      it "renders the associated financial records in the response" do
        expect(response.body).to include(financial_record.formatted_amount)
      end

      it "renders the store details in the response" do
        expect(response.body).to include(store.name)
        expect(response.body).to include(store.formatted_total_balance)
      end
    end

    context "when the store does not exist" do
      before do
        get store_path(999)
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "renders the 404 page" do
        expect(response.body).to include("The page you were looking for doesn’t exist.")
      end
    end
  end
end
