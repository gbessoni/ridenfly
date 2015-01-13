module Company::Validations
  extend ActiveSupport::Concern

  REQUIRED_FIELDS = [
    :name, :contact_first_name, :contact_last_name,
    :street, :city, :state, :zipcode, :phone,
    :dispatch_phone, :website, :description, :airports, :hours_of_operation,
    :pickup_info, :hours_in_advance_to_accept_rez
  ]

  HOURS_OF_OPERATION_FORMAT_REGEXP = /\d+{1,2}:\d{2}(AM|PM)\s*\-\s*\d+{1,2}:\d{2}(AM|PM)/

  included do
    validates *REQUIRED_FIELDS, presence: true
    validates :user, presence: true
    validates :phone, :dispatch_phone, phone_number_format: true
    validates :hours_of_operation, format: HOURS_OF_OPERATION_FORMAT_REGEXP, allow_blank: true
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    validate :check_hoo_times

    before_validation :strip_hours_of_operation
  end

  def strip_hours_of_operation
    self.hours_of_operation = hours_of_operation.to_s.strip
  end

  def check_hoo_times
    if hoo_start.present? && hoo_end.present? && hoo_start > hoo_end
      errors.add(:hours_of_operation, :start_must_be_smaller_then_end)
    end
  end
end
