class AddStoreToFinancialRecords < ActiveRecord::Migration[8.0]
  def change
    add_reference :financial_records, :store, null: false, foreign_key: true
  end
end
