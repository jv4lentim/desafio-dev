class CreateRegistroFinanceiros < ActiveRecord::Migration[8.0]
  def change
    create_table :registro_financeiros do |t|
      t.integer :tipo
      t.date :data
      t.decimal :valor
      t.string :cpf
      t.string :cartao
      t.time :hora
      t.string :dono_da_loja
      t.string :nome_loja

      t.timestamps
    end
  end
end
