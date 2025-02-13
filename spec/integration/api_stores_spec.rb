require 'swagger_helper'

RSpec.describe 'API Stores', type: :request do
  path '/api/stores' do
    get 'Retrieves all stores' do
      tags 'Stores'
      produces 'application/json'
      response '200', 'stores found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              owner: { type: :string }
            },
            required: [ 'id', 'name', 'owner' ]
          }

        let!(:store1) { create(:store, name: "Store 1", owner: "Owner 1") }
        let!(:store2) { create(:store, name: "Store 2", owner: "Owner 2") }

        run_test!
      end
    end
  end

  path '/api/stores/{id}' do
    get 'Retrieves a store' do
      tags 'Stores'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Store id'
      response '200', 'store found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            owner: { type: :string },
            financial_records: {
              type: :array,
              items: { type: :object }
            }
          },
          required: [ 'id', 'name', 'owner' ]

        let(:id) { create(:store, name: "Store 1", owner: "Owner 1").id }
        run_test!
      end

      response '404', 'store not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
