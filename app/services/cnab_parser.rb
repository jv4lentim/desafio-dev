class CnabParser
  def initialize(uploaded_file)
    @uploaded_file_lines = uploaded_file.read.force_encoding("UTF-8").split("\n")
  end

  def call
    uploaded_file_lines.each do |line|
      Sidekiq::ProcessCnabLineJob.perform_async(line)
    end
  end

  attr_accessor :uploaded_file_lines
end
