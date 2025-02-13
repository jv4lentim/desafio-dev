require 'swagger_helper'

RSpec.describe 'API FinancialRecords', type: :request do
  path '/api/financial_records/{id}' do
    get 'Retrieves a financial record' do
      tags 'FinancialRecords'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Financial Record id'
      response '200', 'financial record found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            transaction_type: { type: :string },
            transaction_date: { type: :string, format: 'date' },
            amount: { type: :string },
            cpf_number: { type: :string },
            card_number: { type: :string },
            transaction_time: { type: :string },
            store_owner: { type: :string },
            store_name: { type: :string }
          },
          required: [ 'id', 'transaction_type', 'transaction_date', 'amount', 'cpf_number', 'card_number', 'transaction_time', 'store_owner', 'store_name' ]

        let(:id) { create(:financial_record).id }
        run_test!
      end

      response '404', 'financial record not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
