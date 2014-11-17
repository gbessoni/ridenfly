class Availability
  include Virtus.model

  attribute :airport, String
  

  def rates
    Rate
  end
end
