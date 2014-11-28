module Rate::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :airport
    belongs_to :company
    has_many :pickup_times, class_name: 'Rate::PickupTime', dependent: :delete_all
    has_many :reservations

    accepts_nested_attributes_for :pickup_times, allow_destroy: true
  end
end
