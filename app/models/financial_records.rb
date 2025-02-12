class FinancialRecords < ApplicationRecord
  validates :transaction_type, presence: true
  validates :transaction_date, presence: true
  validates :transaction_time, presence: true
  validates :amount, presence: true
  validates :cpf_number, presence: true
  validates :card_number, presence: true
  validates :store_owner, presence: true
  validates :store_name, presence: true

  def formatted_amount
    "R$ #{amount}"
  end

  def formatted_date
    transaction_date.strftime("%d/%m/%Y")
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
#  transaction_time :time
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
