require 'rails_helper'

RSpec.describe FinancialRecords, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
#  transaction_time :time
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
