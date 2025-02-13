# app/models/store.rb
class Store < ApplicationRecord
  has_many :financial_records, dependent: :destroy
  validates :name, :owner, presence: true, uniqueness: { scope: [ :name, :owner ] }

  def total_balance
    "R$ #{financial_records.sum(:amount)}"
  end

  def as_json(options = {})
    if options[:only]
      super(options)
    else
      super(options.merge(
        methods: :total_balance,
        include: {
          financial_records: { only: [ :id, :amount, :transaction_type, :transaction_date ] }
        }
      ))
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
