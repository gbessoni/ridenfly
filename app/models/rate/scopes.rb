module Rate::Scopes
  extend ActiveSupport::Concern

  included do
    scope :zipcode, ->(zipcode){ where(zipcode: zipcode) }

    scope :by_hotel_as_zipcode, ->(zipcode) do
      where(hotel_by_zipcode: true).zipcode(zipcode)
    end

    scope :by_airport, ->(airport) do
      joins(:airport).where(
        "airports.name = ? OR airports.zipcode = ? OR airports.code = ?",
        airport, airport, airport
      )
    end

    scope :by_zipcode_or_hotel_landmark, ->(s) do
      if s.zipcode.present?
        zipcode(s.zipcode)
      else
        by_hotel_landmark(s)
      end
    end

    scope :by_hotel_landmark, ->(s) do
      by_geo_and_distance(s.lat, s.lng, s.distance)
        .by_hotel_landmark_words(s.hotel_landmark_words)
    end

    scope :by_geo_and_distance, ->(lat, lng, distance) do
      where(
        "earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(rates.lat, rates.lng)",
        lat, lng, distance
      )
    end

    LEVENSHTEIN_THRESHOLD = 0.40 # Smaller value -> bigger restriction -> less fuzzy

    scope :by_hotel_landmark_words, ->(words) do
      size = words.size * LEVENSHTEIN_THRESHOLD
      where('levenshtein(hl_words, ?) < ?', words, size.round)
    end

    scope :levval, ->(words) do
      select("rates.*, levenshtein(hl_words, '#{words}') as lev")
    end

    SCHEDULED = 'Scheduled Shuttle Van'

    scope :scheduled, -> do
      where(vehicle_type_passenger: SCHEDULED)
    end

    scope :precise_by_geo_and_distance, ->(lat,  lng, distance) do
      select(
        "rates.*, earth_distance(ll_to_earth(#{lat.to_f}, #{lng.to_f}), ll_to_earth(rates.lat, rates.lng)) as distance"
      ).where(
        'earth_distance(ll_to_earth(?, ?), ll_to_earth(rates.lat, rates.lng)) <= ?',
        lat, lng, distance
      )
    end

    scope :by_vehicle_capacity, ->(passengers) do
      suitable_types =
        Company::VehicleType
          .where('num_of_passengers >= ?', passengers.to_i)
          .ids
      where(vehicle_capacity_type_id: suitable_types + [nil])
    end
  end
end
