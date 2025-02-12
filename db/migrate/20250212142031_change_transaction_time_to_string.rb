class ChangeTransactionTimeToString < ActiveRecord::Migration[8.0]
  def change
    change_column :financial_records, :transaction_time, :string
  end
end
