class RenameRegistroFinanceirosFields < ActiveRecord::Migration[8.0]
  def change
    rename_table :registro_financeiros, :financial_records

    change_table :financial_records do |t|
      t.rename :tipo, :transaction_type
      t.rename :data, :transaction_date
      t.rename :valor, :amount
      t.rename :cpf, :cpf_number
      t.rename :cartao, :card_number
      t.rename :hora, :transaction_time
      t.rename :dono_da_loja, :store_owner
      t.rename :nome_loja, :store_name
    end
  end
end
