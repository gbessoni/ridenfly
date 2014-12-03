class Availability::Search
  include Virtus.model
  include ActiveModel::Validations
  include TripDirections

  validates :airport, :adults, :flight_time, presence: true
  validates :lat, :lng, :distance, :hotel_landmark, presence: true, if: proc{|rec| rec.zipcode.blank?}

  DOMESTIC = 'domestic'
  INTERNATIONAL = 'international'

  DEFAULT_DISTANCE = 600 # in meters

  attribute :trip_direction, String, default: TO_AIRPORT
  attribute :flight_type, String, default: DOMESTIC

  attribute :airport, String

  attribute :flight_time, Time
  attribute :return_flight_time, Time

  attribute :hotel_landmark_name, String
  attribute :hotel_landmark_street, String
  attribute :hotel_landmark_city, String
  attribute :hotel_landmark_state, String
  attribute :hotel_landmark, String
  attribute :zipcode, String

  attribute :lat, Float
  attribute :lng, Float
  attribute :distance, Float, default: DEFAULT_DISTANCE

  attribute :adults, Integer
  attribute :children, Integer

  def hotel_landmark=(full_name)
    list = full_name.split(',').map(&:strip)
    Rate::HOTEL_LANDMARK_ATTRS.each_with_index do |name, i|
      self[name] ||= list[i]
    end
    super(full_name)
  end

  def hotel_landmark
    super || Rate::HOTEL_LANDMARK_ATTRS.map do |attr|
      send(attr)
    end.join(', ')
  end

  def domestic?
    flight_type == DOMESTIC
  end

  def roundtrip?
    return_flight_time.present?
  end

  def first_leg
    second_leg.second_leg
  end

  def second_leg
    self.dup.tap do |s|
      if s.from_airport?
        s.trip_direction = TO_AIRPORT
      else
        s.trip_direction = FROM_AIRPORT
      end
    end
  end

  def hotel_landmark_words
    @hotel_landmark_words ||= Rate::WordsBuilder.new(
      [hotel_landmark_name, hotel_landmark_street].join(' ')
    ).words
  end
end
