class Availability::Collection
  include Virtus.model

  attribute :search, Availability::Search

  def items
    rates.map do |rate|
      Availability::Item.new(search: search, rate: rate)
    end
  end

  def rates
    Rate.includes(:airport).by_search(search)
  end
end
