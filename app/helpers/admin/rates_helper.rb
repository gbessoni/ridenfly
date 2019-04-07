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

  def vehicle_capacity_type_humanize(company, id)
    name = company.vehicle_types.find_by(id: id)&.name
    if name.present? && capacity.present?
      "#{name.titleize} (#{pluralize(capacity, 'passenger')})"
    else
      'unknown'
    end
  end
end
