class Import::Base
  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attribute :import_file, ActionDispatch::Http::UploadedFile
  attribute :invalid_objects, Array
  attribute :valid_objects, Array

  validates :import_file, presence: true
  validates :company_id, presence: true, allow_nil: true

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

  def new?
    valid_objects.blank? && invalid_objects.blank?
  end
end
