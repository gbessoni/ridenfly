class Reservation < ActiveRecord::Base
  belongs_to :company
  belongs_to :airport

  validates :net_fare, presence: true, numericality: true

  def airport_name
    airport.try(:name)
  end
end
