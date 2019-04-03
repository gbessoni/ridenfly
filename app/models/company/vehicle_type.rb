class Company::VehicleType < ActiveRecord::Base
  belongs_to :company

  PREDEFINED = [
    'Shared-Ride Shuttle Van',
    'Shared Motorcoach',
    'Private Shuttle Van',
    'Private Sedan',
    'Private SUV',
    'Private Limousine',
    'Private Min-van',
    'Scheduled Bus Service'
  ].freeze

  class << self
    def predefined
      PREDEFINED.each.map { |name| { name: name } }
    end
  end
end


# == Schema Information
#
# Table name: company_vehicle_types
#
#  id                :integer         not null, primary key
#  company_id        :integer
#  name              :string
#  how_many          :string
#  num_of_passengers :string
#
# Indexes
#
#  index_company_vehicle_types_on_company_id  (company_id)
#

