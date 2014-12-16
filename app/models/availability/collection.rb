class Availability::Collection
  include Virtus.model

  attribute :search, Availability::Search

  def all(opts = {})
    rates(opts).map do |rate|
      Availability::Item.new(search: search, rate: rate)
    end
  end

  def find(id)
    all(id: id.split('-').first).first
  end

  def rates(opts)
    scope = rates_scope.where(opts)
    result = scope.by_zipcode_or_hotel_landmark(search)
    if result.blank? && search.hotel_landmark_zipcode?
      return scope.by_hotel_as_zipcode(search.hotel_landmark_zipcode)
    end
    result
  end

  def rates_scope
    Rate.includes(:airport).includes(:company)
      .by_airport(search.airport)
      .where('companies.active' => true)
  end
end
