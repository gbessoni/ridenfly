require 'csv'

class Export::Base < Struct.new(:resources)
  class << self
    attr_accessor :columns
  end

  def export_options
    {:col_sep => ';'}
  end

  def generate(options = {})
    CSV.generate(export_options.merge(options)) do |csv|
      yield csv
    end
  end
end
