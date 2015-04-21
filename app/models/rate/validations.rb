module Rate::Validations
  extend ActiveSupport::Concern

  included do
    validates :airport, :company, presence: true
    validates :base_rate, :additional_passenger,
      presence: true, numericality: true
    validates :trip_duration, presence: true,
      numericality: {only_integer: true, greater_than: 0}
    validate :check_pickup_times, :check_lat_lng
    validates :zipcode, presence: true, if: proc{|rec| rec.hotel_by_zipcode?}
  end

  protected

  def check_pickup_times
    if from_airport_pickup_times.any?{|pt| pt.errors.present?}
      errors.add(:from_airport_pickup_time_list, :invalid_format)
    end
    if to_airport_pickup_times.any?{|pt| pt.errors.present?}
      errors.add(:to_airport_pickup_time_list, :invalid_format)
    end
  end

  def check_lat_lng
    if lat.blank? || lng.blank?
      errors.add(:lat_lng, :invalid) if hotel_landmark_name.present?
    end
  end
end
