class Company::VehicleType < ActiveRecord::Base
  acts_as_paranoid

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
      PREDEFINED.map { |name| { name: name } }
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
#  num_of_passengers :integer
#  deleted_at        :datetime
#

