class Company < ActiveRecord::Base
  store_accessor :reservation_notification, :notification_fax, :notification_email

  include Company::Validations

  def vehicle_types
    list = read_attribute(:vehicle_types) || []
    if list.present?
      list.map{ |vt| Company::VehicleType.new(vt) }
    else
      Company::VehicleType.predefined
    end
  end

  def vehicle_types_attributes=(list)
    vts = vehicle_types.map(&:attributes)
    list.each do |id, attrs|
      vts[id.to_i].merge! attrs.symbolize_keys
    end
    write_attribute(:vehicle_types, vts)
  end
end
