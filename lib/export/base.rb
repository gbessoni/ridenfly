require 'csv'

class Export::Base < Struct.new(:resources)
  class << self
    attr_accessor :columns
  end

  def export_options
    {:col_sep => ','}
  end

  def generate(options = {})
    CSV.generate(export_options.merge(options)) do |csv|
      yield csv
    end
  end

  def to_csv
    generate do |csv|
      csv << header
      resources.each do |resource|
        csv << build_row(resource)
      end
    end
  end

  def header
    self.class.columns.values
  end

  def build_row(resource)
    resource.as_json(methods: columns).values_at(*columns)
  end

  def columns
    self.class.columns.keys.map(&:to_s)
  end
end
