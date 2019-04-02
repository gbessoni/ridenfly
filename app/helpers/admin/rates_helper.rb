module Admin::RatesHelper
  def vehicle_capacity_type_humanize(vehicle_capacity_type)
    if vehicle_capacity_type.present?
      vehicle_capacity_type.to_s.titleize + ' ' +
      "(#{Rate::VEHICLES_TYPES_CAPACITY[vehicle_capacity_type.to_sym]} passengers)"
    else
      'unknown'
    end
  end
end
