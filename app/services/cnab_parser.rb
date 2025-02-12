class CnabParser
  def initialize(uploaded_file)
    @uploaded_file_lines = uploaded_file.read.force_encoding("UTF-8").split("\n")
  end

  def call
    uploaded_file_lines.each_with_index do |line, index|
      Sidekiq::ProcessCnabLineJob.perform_in(5.seconds + (index * 1), line)
    end
  end

  attr_accessor :uploaded_file_lines
end
