class Company < ActiveRecord::Base
  store_accessor :reservation_notification, :notification_fax, :notification_email

  has_attached_file :image, :styles => { :medium => "150x110>" }

  include Company::Validations

  belongs_to :user
  has_many :rates
  has_many :reservations, through: :rates
  has_many :payments

  accepts_nested_attributes_for :user

  scope :asc_by_name, ->{ order(:name) }

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

  def image_url(size=:medium)
    image.try(:url, size)
  end

  def hours_of_operation_list
    hours_of_operation.split('-').map(&:strip)
  end

  def hoo_start
    Time.zone.parse(hours_of_operation_list.first) rescue nil
  end

  def hoo_end
    Time.zone.parse(hours_of_operation_list.last) rescue nil
  end
end
