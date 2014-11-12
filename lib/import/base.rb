class Import::Base
  include Virtus.model
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attribute :import_file, ActionDispatch::Http::UploadedFile
  attribute :objects, Array

  class << self
    def import_model
      name = self.to_s.split('::')
      name.shift
      name.join('::').constantize
    end
  end

  def persisted?
    false
  end

  def perform
  end
end
