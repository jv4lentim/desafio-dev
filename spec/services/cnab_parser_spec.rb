require 'rails_helper'

RSpec.describe CnabParser do
  let(:uploaded_file) { fixture_file_upload(Rails.root.join("spec/fixtures/cnab_sample.txt"), "text/plain") }

  let(:cnab_parser) { described_class.new(uploaded_file) }

  describe "#call" do
    it "enqueues a Sidekiq job for each line with the correct delay" do
      allow(Sidekiq::ProcessCnabLineJob).to receive(:perform_in)

      cnab_parser.call

      expect(Sidekiq::ProcessCnabLineJob).to have_received(:perform_in).with(5.seconds, cnab_parser.uploaded_file_lines[0])
      expect(Sidekiq::ProcessCnabLineJob).to have_received(:perform_in).with(6.seconds, cnab_parser.uploaded_file_lines[1])
      expect(Sidekiq::ProcessCnabLineJob).to have_received(:perform_in).with(7.seconds, cnab_parser.uploaded_file_lines[2])
    end
  end
end
