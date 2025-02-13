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
