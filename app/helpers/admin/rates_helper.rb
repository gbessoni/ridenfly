module Admin::RatesHelper
  def vehicle_capacity_types_list(company)
    company.vehicle_types.map do |vt|
      if vt.name.present? && vt.num_of_passengers.present?
        [
          "#{vt.name.titleize} (#{vt.num_of_passengers} passengers)",
          vt.id
        ]
      end
    end.compact
  end

  def vehicle_capacity_type_humanize(vehicle_type)
    return 'unknown' unless vehicle_type

    name = vehicle_type.name
    capacity = vehicle_type.num_of_passengers
    if name.present? && capacity.present?
      "#{name.titleize} (#{capacity} passengers)"
    end
  end
end
