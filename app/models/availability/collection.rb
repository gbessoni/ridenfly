class Availability::Collection
  include Virtus.model

  attribute :search, Availability::Search

  def all(opts = {})
    rates(opts).map do |rate|
      item = Availability::Item.new(search: search, rate: rate)
      item.valid? ? item : nil
    end.compact
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
    Rate.joins(:airport).joins(:company)
      .by_vehicle_capacity(search.adults.to_i + search.children.to_i)
      .by_airport(search.airport)
      .where('companies.active' => true)
  end
end
