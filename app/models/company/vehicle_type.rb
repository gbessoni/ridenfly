class Company::VehicleType
  include Virtus.model

  attribute :id,               Integer
  attribute :name,             String
  attribute :how_many,         String
  attribute :num_of_passengers, String

  PREDEFINED = [
    'Shared-Ride Shuttle Van',
    'Shared Motorcoach',
    'Private Shuttle Van',
    'Private Sedan',
    'Private SUV',
    'Private Limousine',
    'Private Min-van',
    'Scheduled Bus Service'
  ]

  class << self
    def predefined
      PREDEFINED.each_with_index.map do |name, i|
        new(name: name, id: i)
      end
    end
  end

  def persisted?
    true
  end
end
