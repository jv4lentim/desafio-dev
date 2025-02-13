class FinancialRecord < ApplicationRecord
  belongs_to :store

  validates :transaction_type, presence: true
  validates :transaction_date, presence: true
  validates :transaction_time, presence: true
  validates :amount, presence: true
  validates :cpf_number, presence: true
  validates :card_number, presence: true
  validates :store_owner, presence: true
  validates :store_name, presence: true

  enum :transaction_type, {
    debit: 1,
    ticket: 2,
    financing: 3,
    credit: 4,
    loan_receipt: 5,
    sales: 6,
    ted_receipt: 7,
    doc_receipt: 8,
    rent: 9
  }, suffix: true

  def formatted_amount
    "R$ #{amount}"
  end

  def formatted_date
    transaction_date.strftime("%d/%m/%Y")
  end

  def transaction_description
    I18n.t("transaction_types.#{transaction_type}.description")
  end

  def as_json(options = {})
    super(options.merge(
      methods: [ :formatted_amount, :formatted_date ]
    ))
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
