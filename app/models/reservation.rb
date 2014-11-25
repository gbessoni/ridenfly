class Reservation < ActiveRecord::Base
  belongs_to :rate
  belongs_to :sibling, class_name: 'Reservation'

  validates :net_fare, presence: true, numericality: true

  def airport_name
    airport.try(:name)
  end

  def company_name
    company.try(:name)
  end

  def airport
    rate.try(:airport)
  end

  def company
    rate.try(:company)
  end
end
