FactoryBot.define do
  factory :financial_record do
    amount { 100.0 }
    transaction_type { 1 }
    transaction_date { Date.today }
    transaction_time { "12:34:56" }
    cpf_number { "12345678901" }
    card_number { "1234****5678" }
    store_owner { "Dono Exemplo" }
    store_name { "Loja Exemplo" }
    association :store
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
#  store_id         :bigint           not null
#
# Indexes
#
#  index_financial_records_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
