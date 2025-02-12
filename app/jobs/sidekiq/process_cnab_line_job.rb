class Sidekiq::ProcessCnabLineJob
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform(line)
    return if line.strip.empty?

    data = parse_transaction_data(line)
    persist_transaction(data)
  rescue StandardError
    Rails.logger.error "Erro ao processar linha de transação"
  end

  private

  def parse_transaction_data(line)
    {
      transaction_type: line[0].to_i,
      transaction_date: Date.strptime(line[1..8], "%Y%m%d"),
      amount: adjust_value_sign(line[0], line[9..18].to_f),
      cpf_number: line[19..29],
      card_number: line[30..41],
      transaction_time: Time.strptime(line[42..47], "%H%M%S").strftime("%H:%M:%S"),
      store_owner: line[48..61].strip,
      store_name: line[62..-1].strip
    }
  end

  def adjust_value_sign(transaction_type, amount)
    %w[2 3 9].include?(transaction_type) ? -(amount.to_f / 100) : (amount.to_f / 100)
  end

  def persist_transaction(data)
    financial_record = FinancialRecord.find_by(data)
    return if financial_record.present?

    FinancialRecord.create!(data)
  end
end
