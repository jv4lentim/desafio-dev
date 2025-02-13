require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:valid_attributes) do
    {
      name: "Loja Exemplo",
      owner: "Dono Exemplo"
    }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      store = Store.new(valid_attributes)
      expect(store).to be_valid
    end

    it "is invalid without a name" do
      store = Store.new(valid_attributes.merge(name: nil))
      expect(store).not_to be_valid
      expect(store.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an owner" do
      store = Store.new(valid_attributes.merge(owner: nil))
      expect(store).not_to be_valid
      expect(store.errors[:owner]).to include("can't be blank")
    end

    it "is invalid with a duplicate name and owner combination" do
      Store.create!(valid_attributes)
      store = Store.new(valid_attributes)
      expect(store).not_to be_valid
      expect(store.errors[:name]).to include("has already been taken")
    end
  end

  describe "#total_balance" do
    let(:store) { Store.create!(valid_attributes) }
    let!(:financial_record1) { create(:financial_record, amount: 100.0, store:) }
    let!(:financial_record2) { create(:financial_record, amount: 200.0, store:) }

    it "returns the total balance of all financial records" do
      expect(store.total_balance).to eq("R$ 300.0")
    end

    it "returns R$ 0.0 when there are no financial records" do
      store.financial_records.destroy_all

      expect(store.total_balance).to eq("R$ 0.0")
    end
  end
end

# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string
#  owner      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stores_on_name_and_owner  (name,owner) UNIQUE
#
