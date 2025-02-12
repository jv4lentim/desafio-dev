require 'rails_helper'

RSpec.describe Sidekiq::ProcessCnabLineJob, type: :job do
  describe "#perform" do
    let(:valid_line) { "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       " }
    let(:negative_amount_line) { "2201903010000010700845152540738723****9987123333MARCOS PEREIRAMERCADO DA AVENIDA" }
    let(:empty_line) { "   " }

    before { FinancialRecord.destroy_all }

    context "with a valid line" do
      it "creates a new FinancialRecord" do
        expect {
          described_class.new.perform(valid_line)
        }.to change(FinancialRecord, :count).by(1)
      end

      it "parses the data correctly" do
        described_class.new.perform(valid_line)
        record = FinancialRecord.last

        aggregate_failures do
          expect(record.transaction_type).to eq(3)
          expect(record.transaction_date).to eq(Date.new(2019, 3, 1))
          expect(record.amount).to eq(-142.00) # Type 3 inverts the sign
          expect(record.cpf_number).to eq("09620676017")
          expect(record.card_number).to eq("4753****3153")
          expect(record.transaction_time).to eq("15:34:53")
          expect(record.store_owner).to eq("JOÃO MACEDO")
          expect(record.store_name).to eq("BAR DO JOÃO")
        end
      end
    end

    context "with an empty line" do
      it "does not create a record" do
        expect {
          described_class.new.perform(empty_line)
        }.not_to change(FinancialRecord, :count)
      end
    end

    context "with a transaction type that inverts the sign" do
      it "applies a negative value" do
        described_class.new.perform(negative_amount_line)
        expect(FinancialRecord.last.amount).to eq(-107.00)
      end
    end

    context "with a duplicate record" do
      before do
        described_class.new.perform(valid_line)
      end

      it "does not create a duplicate" do
        expect {
          described_class.new.perform(valid_line)
        }.not_to change(FinancialRecord, :count)
      end
    end

    context "with invalid format" do
      let(:invalid_line) { "9XXXXXinvalid_data" }

      it "does not create a record and logs an error" do
        allow(Rails.logger).to receive(:error)

        expect {
          described_class.new.perform(invalid_line)
        }.not_to change(FinancialRecord, :count)

        expect(Rails.logger).to have_received(:error).with("Erro ao processar linha de transação")
      end
    end
  end

  describe "#adjust_value_sign" do
    it "inverts the sign for types 2, 3, 9" do
      job = described_class.new

      expect(job.send(:adjust_value_sign, "2", 100)).to eq(-1.00)
      expect(job.send(:adjust_value_sign, "3", 200)).to eq(-2.00)
      expect(job.send(:adjust_value_sign, "9", 300)).to eq(-3.00)
    end

    it "keeps a positive sign for other types" do
      job = described_class.new

      expect(job.send(:adjust_value_sign, "1", 100)).to eq(1.00)
      expect(job.send(:adjust_value_sign, "4", 200)).to eq(2.00)
    end
  end
end
