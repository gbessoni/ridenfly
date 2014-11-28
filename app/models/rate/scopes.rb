module Rate::Scopes
  extend ActiveSupport::Concern

  included do
    scope :by_search, ->(search) do
      by_airport(search.airport)
        .by_zipcode_or_hotel_landmark(search)
    end

    scope :by_airport, ->(airport) do
      joins(:airport).where(
        "airports.name = ? OR airports.zipcode = ? OR airports.code = ?",
        airport, airport, airport
      )
    end

    scope :by_zipcode_or_hotel_landmark, ->(s) do
      if s.zipcode.present?
        where(zipcode: s.zipcode)
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

    LEVENSHTEIN_THRESHOLD = 0.75

    scope :by_hotel_landmark_words, ->(words) do
      size = words.size * LEVENSHTEIN_THRESHOLD
      where('levenshtein(hl_words, ?) < ?', words, size.round)
    end

    scope :levval, ->(words) do
      select("rates.*, levenshtein(hl_words, '#{words}') as lev")
    end
  end
end
