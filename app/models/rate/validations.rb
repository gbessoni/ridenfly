module Rate::Validations
  extend ActiveSupport::Concern

  included do
    validates :airport, :company, presence: true
    validates :base_rate, :additional_passenger,
      presence: true, numericality: true
    validates :trip_duration, presence: true,
      numericality: {only_integer: true, greater_than: 0}
    validate :check_pickup_times, :check_lat_lng
    before_save :set_hl_words
  end

  protected

  def check_pickup_times
    if pickup_times.any?{|pt| pt.errors.present?}
      errors.add(:pickup_time_list, :invalid_format)
    end
  end

  def check_lat_lng
    if lat.blank? || lng.blank?
      errors.add(:lat_lng, :invalid) if hotel_landmark_name.present?
    end
  end

  def set_hl_words
    self.hl_words = Rate::WordsBuilder.new(hotel_landmark).words
  end
end
