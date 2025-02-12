require 'rails_helper'

RSpec.describe FinancialRecord, type: :model do
  let(:valid_attributes) do
    {
      transaction_type: 1,
      transaction_date: Date.today,
      transaction_time: "12:34:56",
      amount: 100.50,
      cpf_number: "12345678901",
      card_number: "1234****5678",
      store_owner: "John Doe",
      store_name: "John's Store"
    }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      record = FinancialRecord.new(valid_attributes)
      expect(record).to be_valid
    end

    %i[
      transaction_type
      transaction_date
      transaction_time
      amount
      cpf_number
      card_number
      store_owner
      store_name
    ].each do |attribute|
      it "is invalid without #{attribute}" do
        record = FinancialRecord.new(valid_attributes.merge(attribute => nil))
        expect(record).not_to be_valid
        expect(record.errors[attribute]).to include("can't be blank")
      end
    end
  end

  describe "#formatted_amount" do
    it "returns the amount formatted as Brazilian Real" do
      record = FinancialRecord.new(valid_attributes.merge(amount: 150.75))
      expect(record.formatted_amount).to eq("R$ 150.75")
    end

    it "handles negative amounts correctly" do
      record = FinancialRecord.new(valid_attributes.merge(amount: -99.99))
      expect(record.formatted_amount).to eq("R$ -99.99")
    end
  end

  describe "#formatted_date" do
    it "returns the transaction date formatted as DD/MM/YYYY" do
      record = FinancialRecord.new(valid_attributes.merge(transaction_date: Date.new(2023, 10, 5)))
      expect(record.formatted_date).to eq("05/10/2023")
    end
  end
end

# == Schema Information
#
# Table name: financial_records
#
#  id               :bigint           not null, primary key
#  amount           :decimal(, )
#  card_number      :string
#  cpf_number       :string
#  store_name       :string
#  store_owner      :string
#  transaction_date :date
#  transaction_time :string
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
