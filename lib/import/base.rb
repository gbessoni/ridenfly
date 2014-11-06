class Import::Base
  include Virtus.model

  attribute :import_file, ActionDispatch::Http::UploadedFile

  class << self
    def import_model
      name = self.to_s.split('::')
      name.shift
      name.join('::').constantize
    end
  end
end
