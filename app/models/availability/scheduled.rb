class Availability::Scheduled < Availability::Collection
  delegate :lat, :lng, :schd_distance, to: :search

  def rates(opts)
    scope = rates_scope.where(opts)
    scope.scheduled.precise_by_geo_and_distance(lat, lng, schd_distance)
  end
end
