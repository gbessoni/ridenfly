class Availability::Collection
  include Virtus.model

  attribute :search, Availability::Search

  def all(opts = {})
    rates(opts).map do |rate|
      Availability::Item.new(search: search, rate: rate)
    end
  end

  def find(id)
    all(id: id.split('-').first).first
  end

  def rates(opts)
    Rate.includes(:airport).includes(:company).by_search(search).where(opts)
  end
end
