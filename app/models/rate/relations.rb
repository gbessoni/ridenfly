module Rate::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :airport
    belongs_to :company
    has_many :to_airport_pickup_times, ->{ where(direction: Rate::PickupTime::TO_AIRPORT) },
      class_name: 'Rate::PickupTime', dependent: :delete_all
    has_many :from_airport_pickup_times, ->{ where(direction: Rate::PickupTime::FROM_AIRPORT) },
      class_name: 'Rate::PickupTime', dependent: :delete_all
    has_many :reservations

    accepts_nested_attributes_for :to_airport_pickup_times, allow_destroy: true
    accepts_nested_attributes_for :from_airport_pickup_times, allow_destroy: true
  end
end
