class Company < ActiveRecord::Base
  store_accessor :reservation_notification, :notification_fax, :notification_email

  has_attached_file :image#, :styles => { :medium => "150x110>" }

  acts_as_paranoid
  include Company::Validations

  belongs_to :user
  has_many :rates
  has_many :reservations, through: :rates
  has_many :payments

  accepts_nested_attributes_for :user

  scope :asc_by_name, ->{ order(:name) }

  has_many :vehicle_types,  -> { order(:num_of_passengers) },
           class_name: 'VehicleType',
           dependent: :destroy,
           inverse_of: :company
  accepts_nested_attributes_for :vehicle_types, allow_destroy: true

  def vehicle_types
    super.present? ? super : super.build(VehicleType.predefined)
  end

  def image_url(size=:original)
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



# == Schema Information
#
# Table name: companies
#
#  id                             :integer         not null, primary key
#  user_id                        :integer
#  name                           :string
#  contact_first_name             :string
#  contact_last_name              :string
#  street                         :string
#  state                          :string
#  zipcode                        :string
#  phone                          :string
#  mobile                         :string
#  dispatch_phone                 :string
#  website                        :string
#  description                    :text
#  reservation_notification       :hstore
#  blackout_dates                 :text
#  airports                       :text
#  hours_of_operation             :string
#  hours_in_advance_to_accept_rez :string
#  pickup_info                    :text
#  after_hours_info               :text
#  excess_luggage_charge          :string
#  luggage_insured                :boolean         default("false")
#  child_rate                     :string
#  child_car_seats_included       :boolean         default("false")
#  luggage_limitation_policy      :text
#  company_reservation_policy     :text
#  company_cancellation_policy    :text
#  child_safety_policy            :text
#  pet_car_seat_policy            :text
#  other_vehicle_types            :text
#  created_at                     :datetime
#  updated_at                     :datetime
#  vehicle_types                  :hstore
#  fax                            :string
#  city                           :string
#  active                         :boolean         default("true")
#  image_file_name                :string
#  image_content_type             :string
#  image_file_size                :integer
#  image_updated_at               :datetime
#  no_pickup_message              :string
#  active_to_airport              :boolean         default("true")
#  active_from_airport            :boolean         default("true")
#  commission                     :decimal(8, 2)   default("0.0")
#  payment_type                   :string
#  airport_pickup_fee             :decimal(8, 2)   default("0.0")
#  confirmation_emails            :string
#  deleted_at                     :datetime
#

